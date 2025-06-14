//import 'dart:ffi';

import 'package:section13/services/networking.dart';
import '/services/location.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const openWeatherMapUrl =  'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future <dynamic> getLocationWeather  () async{

    final String? apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];
    print('$apiKey');
    if (apiKey == null) {
      //print("❌ API key not loaded from .env");
      return;
    }
    Location location = Location();
    await location.getCurrentLocation();

    // Using Palm Springs coordinates for now
    double? lat = 0; // or: location.latitude
    double? lon = 0; // or: location.longitude

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapUrl?lat=$lat&lon=$lon&appid=$apiKey&units=imperial'
    );

    var weatherData = await networkHelper.getData();
    print(weatherData);
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
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
