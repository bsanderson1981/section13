import 'package:flutter/material.dart';
import 'package:section13/screens/city_screen.dart';
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
//check before load screens we have weather date or not
  if (weatherData == null) {
    temperature = 0;
    weatherIcon = 'Error';
    messageText = 'Unable to get weather data';
    cityName = '';
    return;

  }
  temperature = weatherData['main']['temp'].toDouble();
    //temperature = weatherData['main']['temp'];
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

                    onPressed: () async {
                      var weatherData  = await  weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: ()  async {
                      var typedName  = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                        if (typedName != null){
                         var weatherData =  await weather.getCityWeather(typedName);
                         updateUI(weatherData);

                        }
                    },
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
