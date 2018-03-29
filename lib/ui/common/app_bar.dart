import 'package:flutter/material.dart';

/* Custom app bar with gradient. Not being used **************************************************************************************/
class GradientAppBar extends StatelessWidget {

  final String title;
  final double barHeight = 65.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
      .of(context)
      .padding
      .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child: new Center(
        child: new Text(title,
          style:const TextStyle(
            color: Colors.black54,
            // fontFamily: 'oxygen',
            fontWeight: FontWeight.w200,
            fontSize: 34.0
          ),
        ),
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [
            const Color(0xFFd4fc79),
            const Color(0xFF96e6a1)
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 1.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp
        ),
      ),
    );
  }
}