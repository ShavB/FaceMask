import 'package:face_mask/hompage.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: HomePage(),
      title: Text(
        "FACE MASK DETECTION",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      image: Image.asset("assets/splashScreen.png"),
      photoSize: 130,
      backgroundColor: Colors.white,
      loaderColor: Colors.black,
      loadingText: Text(
        "Loading: ",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
