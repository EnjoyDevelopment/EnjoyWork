import 'package:flutter/material.dart';

//*todo*//

class SummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      body: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              onPressed: () {
                button2(context);
              },
              child: new Text("Back to Screen 1"),
            )
          ],
        ),
      ),
    );
  }

  void button2(BuildContext context) {
    print("Button 2"); //3
    Navigator.of(context).pop(true); //4
  }
}
