import 'package:flutter/material.dart';
import '/services/location.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation(); // Automatically run when the widget is inserted into the tree
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    final double lat = location.latitude;
    final double lon = location.longitude;
    print('Latitude: $lat');
    print('Longitude: $lon');

    getData(lat, lon); // Now fetch weather data using coordinates
  }

  void getData(double lat, double lon) async {
    http.Response  response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=50836a4419e6435e0b1f803d6a434a23'),
    );

    if (response.statusCode == 200) {
      print(response.body); // raw JSON output
      print('RCode: ${response.statusCode}');
    } else {
      print('Failed to get weather data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Loading...')),
    );
  }
}
