import 'package:flutter/material.dart';
import 'package:shambatestbavon/Forever/Constants.dart';
import 'package:shambatestbavon/Pages/Splash.dart';
//! in this test app i've used sharedprefernce for local data storage
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bavon demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: ALPHACOLOR
      ),
      home: SplashPage(

      ),
    );
  }
}

