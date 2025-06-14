import 'package:flutter/material.dart';
import 'package:section13/screens/location_screen.dart';
//import 'package:section13/services/networking.dart';
//import '/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:section13/services/weather.dart';
//import 'city_screen.dart';



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

  void getLocationData()  async {
   // WeatherModel weatherModel = WeatherModel();
    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push( context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }
    ));
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
