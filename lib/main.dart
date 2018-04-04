import 'package:flutter/material.dart';
import 'helper/navigation_manager.dart';
import 'ui/home/home_page.dart';

void main() => runApp(new EnjoyWork());

class EnjoyWork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "Enjoy Work",
        home: new HomePage(),
        routes: NavigationManager.routeBuilder);
  }
}
