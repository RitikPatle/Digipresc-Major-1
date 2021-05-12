import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:drtalk_majprojtwo/Screens/Home.dart';
import 'package:drtalk_majprojtwo/Screens/Loginscreen.dart';
import 'package:drtalk_majprojtwo/Screens/Splashscreen.dart';
import 'package:drtalk_majprojtwo/Screens/Newprescscreen.dart';
import 'package:drtalk_majprojtwo/Screens/Userdatascreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DrTalk());
}

class DrTalk extends StatefulWidget {
  @override
  _DrTalkState createState() => _DrTalkState();
}

class _DrTalkState extends State<DrTalk> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => splashScreen(),
        '/login': (context) => loginScreen(),
        '/home': (context) => home(),
        '/userdata': (context) => aboutUserScreen(),
        '/newpresc': (context) => newPresc(),
      },
      title: 'DrTalk',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
