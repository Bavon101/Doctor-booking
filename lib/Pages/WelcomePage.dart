import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shambatestbavon/Forever/AllFatherFunctions.dart';
import 'package:shambatestbavon/Forever/Constants.dart';
import 'package:shambatestbavon/Pages/UserAuth/LoginScreen.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool resize = false;
  _resize() {
    delayTime(then: () {
      setState(() {
            resize = true;
          });
    },seconds: 1);
    
  }

  @override
  void initState() {
    super.initState();
    _resize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: HEIGHT(context: context),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: AnimatedContainer(
                    height: !resize
                        ? HEIGHT(context: context) * .45
                        : HEIGHT(context: context) * .30,
                    width: !resize
                        ? WIDTH(context: context) * .80
                        : WIDTH(context: context) * .60,
                    duration: Duration(milliseconds: 700),
                    child: Lottie.asset(
                      LOTTIEJSON,
                    ),
                  ),
                ),
                spaceAnime(context: context, animated: resize),
                AnimatedCrossFade(
                  firstCurve: Curves.easeOutBack,
                  secondCurve: Curves.easeInBack,
                  firstChild: Container(),
                  secondChild: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Proceed as a Doctor or Patient',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: WIDTH(context: context) * .12),
                          ),
                          spaceAnime(context: context, animated: resize),
                          _patientButton(),
                          spaceAnime(context: context, animated: resize),
                          _doctorButton(),
                        ],
                      ),
                    ),
                  ),
                  crossFadeState: !resize
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: Duration(seconds: 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _doctorButton() => Container(
        width: WIDTH(context: context) * .80,
        decoration: BoxDecoration(
            color: ALPHAMEDIUM,
            borderRadius: BorderRadius.circular(WIDTH(context: context) * .10)),
        child: TextButton(
          onPressed: () {
            Navigator.push(context, getRoute(childto: LoginPage(doctor: true)));
          },
          child: Text('I\'m a Doctor',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: resize
                      ? WIDTH(context: context) * .05
                      : WIDTH(context: context) * .05)),
        ),
      );
  Widget _patientButton() => Container(
        width: WIDTH(context: context) * .80,
        decoration: BoxDecoration(
            color: ALPHALIGHT,
            borderRadius: BorderRadius.circular(WIDTH(context: context) * .10)),
        child: TextButton(
          onPressed: () {
            Navigator.push(
                context, getRoute(childto: LoginPage(doctor: false)));
          },
          child: Text('I\'m a Patient',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: resize
                      ? WIDTH(context: context) * .05
                      : WIDTH(context: context) * .05)),
        ),
      );
}
