import 'package:flutter/material.dart';
import 'package:section13/screens/location_screen.dart';
import 'package:section13/services/networking.dart';
import '/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



///final String? apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();


}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    getLocationData(); // Automatically run when the widget is inserted into the tree
  }

  void getLocationData() async {

      final String? apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];
      if (apiKey == null) {
        print("❌ API key not loaded from .env");
        return;
      }
    Location location = Location();
    await location.getCurrentLocation();

    // Using Palm Springs coordinates for now
    final double lat = 33.8303; // or: location.latitude
    final double lon = -116.5453; // or: location.longitude

    NetworkHelper networkHelper = NetworkHelper(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=imperial'
    );

    var weatherData = await networkHelper.getData();
    print(weatherData);

    Navigator.push( context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SpinKitDoubleBounce(
        color: Colors.white,
        size:  100.0,

      )),
    );
  }
}
