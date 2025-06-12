import 'package:flutter/material.dart';
import 'package:section13/utilities/constants.dart';
import 'package:section13/services/weather.dart';

class LocationScreen extends StatefulWidget {

LocationScreen ({ this.locationWeather});
final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weather = WeatherModel();
  late  double temperature;
String? weatherIcon;
  late String cityName;
  String? messageText;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }


  void updateUI (dynamic weatherData){
    setState(() {


    temperature = weatherData['main']['temp'];
    int tempRound =  temperature.round();
 var condition = weatherData['weather'] [0] ['id'];
 weatherIcon = weather.getWeatherIcon(condition);
  messageText  = weather.getMessage(tempRound);
  cityName = weatherData['name'];
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white, BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                  //  '$cityName',
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temperature.toStringAsFixed(0)}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      ('$weatherIcon'),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  ('$messageText in  $cityName'),
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
