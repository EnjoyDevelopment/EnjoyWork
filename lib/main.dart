import 'package:flutter/material.dart';
import 'ui/home/home_page.dart';
import 'ui/summary/SummaryPage.dart';

void main() => runApp(new EnjoyWork());

class EnjoyWork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "Enjoy Work",
        home: new HomePage(),
        routes: <String, WidgetBuilder>{
        '/SummaryPage': (BuildContext context) =>new SummaryPage()
        });
  }
}

