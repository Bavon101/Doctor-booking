import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shambatestbavon/Forever/AllFatherFunctions.dart';
import 'package:shambatestbavon/Forever/AuthLogic.dart';
import 'package:shambatestbavon/Forever/Constants.dart';
import 'package:shambatestbavon/Models/User.dart';
import 'package:shambatestbavon/Pages/HomePage.dart';
import 'package:shambatestbavon/Pages/UserAuth/LoginScreen.dart';
import 'package:shambatestbavon/Pages/WelcomePage.dart';

UserAuth _userAuth = new UserAuth();

class SplashPage extends StatefulWidget {
  SplashPage({Key key, this.delete}) : super(key: key);
  final bool delete;

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool logedIn = false;
  goToWhereNecessary() {
    delayTime(
      seconds: 1,
        then: () => Navigator.pushReplacement(
            context,
            getRoute(
                childto: !logedIn
                    ? WelcomePage()
                    : HomePage(
                        user: _user,
                      ))));
  }

  User _user;
  screensLogic() {
    _userAuth.isUserLoggedIn().then((status) {
      setState(() {
        logedIn = status;
      });
      _userAuth.saveGetUser().then((value) {
        setState(() {
          _user = value;
        });
        goToWhereNecessary();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.delete == null) {
      screensLogic();
    } else {
      _userAuth.saveGetUser().then((value) {
         screensLogic();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Lottie.asset(LOTTIEJSON,
                height: HEIGHT(context: context) * .45,
                width: WIDTH(context: context) * .80),
          ),
          Positioned(
              bottom: HEIGHT(context: context) * .05,
              right: WIDTH(context: context) * .35,
              left: WIDTH(context: context) * .35,
              child: Container(
                  decoration: BoxDecoration(
                    color: ALPHACOLOR,
                    borderRadius:
                        BorderRadius.circular(WIDTH(context: context) * .10),
                  ),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Doctor Bavon',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))))
        ],
      ),
    );
  }
}
