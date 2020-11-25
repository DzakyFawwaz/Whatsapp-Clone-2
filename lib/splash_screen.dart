import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/register_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashScreen();
  }

  void splashScreen() {
    var duration = const Duration(seconds: 3);
    Timer(duration, () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.green),
          ),
          Center(
              child: Container(
            width: 100,
            height: 100,
            child: Image(
                fit: BoxFit.contain, image: AssetImage("images/walogo.png")),
          )),
        ],
      ),
    );
  }
}
