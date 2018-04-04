import 'package:flutter/material.dart';
import '../ui/summary/summary_page.dart';

class NavigationManager {
  static String summaryPageRoute = "/summary_page";

  static Map get routeBuilder {
    var routes = <String, WidgetBuilder>{
      summaryPageRoute: (BuildContext context) => new SummaryPage()
    };

    return routes;
  }

  static void navigate(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }
}
