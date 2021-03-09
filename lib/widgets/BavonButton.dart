import 'package:flutter/material.dart';
import 'package:shambatestbavon/Forever/AllFatherFunctions.dart';
import 'package:shambatestbavon/Forever/Constants.dart';

class BavonButton extends StatelessWidget {
  const BavonButton({Key key, @required this.onTap, @required this.text,this.color})
      : super(key: key);
  final Function onTap;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 700),
      decoration: BoxDecoration(
          color:color == null ? ALPHACOLOR:color,
          borderRadius: BorderRadius.circular(WIDTH(context: context) * .10)),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: WIDTH(context: context) * .05),
        ),
      ),
    );
  }
}
