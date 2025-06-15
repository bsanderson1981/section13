import 'package:section13/services/networking.dart';
import '/services/location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    final String? apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];
    if (apiKey == null) {
      print("❌ API key not loaded from .env");
      return;
    }

    Location location = Location();
    await location.getCurrentLocation();

    double? lat = location.latitude;
    double? lon = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
      '$openWeatherMapUrl?lat=$lat&lon=$lon&appid=$apiKey&units=imperial',
    );

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    final String? apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];
    if (apiKey == null) {
      print("❌ API key not loaded from .env");
      return;
    }

    NetworkHelper networkHelper = NetworkHelper(
      '$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=imperial',
    );

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 77) {
      return 'It\'s 🍦 time';
    } else if (temp > 68) {
      return 'Time for shorts and 👕';
    } else if (temp < 50) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
