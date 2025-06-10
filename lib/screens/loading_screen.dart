import 'package:flutter/material.dart';
import 'package:section13/screens/location_screen.dart';
import 'package:section13/services/networking.dart';
import '/services/location.dart';

const apiKey = '50836a4419e6435e0b1f803d6a434a23';

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
    Location location = Location();
    await location.getCurrentLocation();

    // Using Palm Springs coordinates for now
    final double lat = 33.8303; // or: location.latitude
    final double lon = -116.5453; // or: location.longitude

    NetworkHelper networkHelper = NetworkHelper(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey',
    );

    var weatherData = await networkHelper.getData();
    print(weatherData);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Loading...')),
    );
  }
}

/*
double wtemp = decodeData['main']['temp'];
print('Temperature: $wtemp');

int weatherId = decodeData['weather'][0]['id'];
print('Weather ID: $weatherId');

String name = decodeData['name'];
print('City Name: $name');
*/
