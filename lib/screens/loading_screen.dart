import 'package:flutter/material.dart';
import '/services/location.dart';
//start section 13   142
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
    print(location.latitude);
    print(location.longitude);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}
