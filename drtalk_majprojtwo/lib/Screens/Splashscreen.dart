import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:drtalk_majprojtwo/Screens/Loginscreen.dart';

// ignore: camel_case_types
class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

// ignore: camel_case_types
class _splashScreenState extends State<splashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SplashScreen(
        seconds: 5,
        navigateAfterSeconds: loginScreen(),
        image: Image.asset(
          'assets/logo.png',
          color: Color(0xFFB40284A),
        ),
        photoSize: 100,
        backgroundColor: Colors.white,
        loaderColor: Color(0xFFB40284A),
      ),
    );
  }
}
