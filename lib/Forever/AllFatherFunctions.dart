import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shambatestbavon/Forever/Constants.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

double HEIGHT({@required BuildContext context}) =>
    MediaQuery.of(context).size.height;
double WIDTH({@required BuildContext context}) =>
    MediaQuery.of(context).size.width;

Route getRoute({@required Widget childto}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => childto,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Widget spaceAnime({@required BuildContext context, @required bool animated}) =>
    AnimatedContainer(
        height: !animated ? 0 : HEIGHT(context: context) * .05,
        duration: Duration(milliseconds: 1200));

delayTime({@required Function then, int seconds = 3}) =>
    Timer(Duration(seconds: seconds), then);

showToast({@required String message, Color color}) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: ALPHACOLOR,
    textColor: color == null ? Colors.white : color,
    fontSize: 16.0);

showBottom({@required BuildContext context, @required Widget child}) =>
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return child;
        });
var uuid = Uuid();
String getUUID() => uuid.v4();
exit({@required BuildContext context}) => Navigator.pop(context);
