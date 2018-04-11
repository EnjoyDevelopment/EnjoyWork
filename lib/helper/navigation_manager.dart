import 'package:flutter/material.dart';
import '../ui/common/video.dart';
import '../ui/summary/summary_page.dart';

class NavigationManager {
  static String summaryPageRoute = "/summary_page";
  static String videoPageRoute = "/video";

  static Map get routeBuilder {
    var routes = <String, WidgetBuilder>{
      summaryPageRoute: (BuildContext context) => new SummaryPage(),
      videoPageRoute: (BuildContext context) => new VideoPage()
    };

    return routes;
  }

  static void navigate(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }
}
