import 'package:flutter/material.dart';

class AppBarComponent {
  Widget getComponent() {
    return new AppBar(
        centerTitle: true,
        title: new Text("Enjoy Work",
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontFamily: "jose",
              fontSize: 28.0,
              color: const Color(0xFFFFFFFF),
              fontWeight: FontWeight.w700,
            )),
        elevation: 18.0,
        backgroundColor: const Color(0xFFea1136));
  }
}
