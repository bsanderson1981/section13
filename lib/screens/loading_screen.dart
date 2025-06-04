import 'package:flutter/material.dart';
//git init && git add . && git commit -m "Initial commit" && git remote add origin https://github.com/bsanderson1981/section8 && git branch -M main && git push -u origin main

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Get the current location
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
