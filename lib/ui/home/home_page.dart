import 'package:flutter/material.dart';

enum Emotion { happy, normal, sad }

class HomePage extends StatefulWidget {
  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  FocusNode _emotionTextInputFocusNode;
  double    _actionIconSize;
  double    _questionTextFontSize;
  bool      _emotionIconsVisible;
  String    _questionText;

  @override
  void initState() {
    super.initState();
    _emotionIconsVisible       = true;
    _actionIconSize            = 85.0;
    _questionTextFontSize      = 25.0;
    _questionText              = "How are you today ?";
    _emotionTextInputFocusNode = new FocusNode();
    _emotionTextInputFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    debugPrint("Focus: " + _emotionTextInputFocusNode.hasFocus.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          centerTitle: true,
          title: new Text("Enjoy Work",
              textAlign: TextAlign.center,
              style: new TextStyle(
                //fontFamily: "jose",
                fontSize: 28.0,
                color: Colors.black54,
                fontWeight: FontWeight.w200,
              )),
          elevation: 10.0,
          backgroundColor: Colors.orange),
      body: new Column(children: <Widget>[
        new Flexible(
          child: new Container(
            margin: new EdgeInsets.only(
                left: 10.0, right: 10.0, top: 65.0, bottom: 45.0),
            child: new Text(
              _questionText,
              style: new TextStyle(
                fontFamily: "jose",
                fontSize: _questionTextFontSize,
                color: Colors.black54,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
         _emotionIconsVisible
            ? new Row(
                children: <Widget>[
                  new Expanded(
                    child: new IconButton(
                      icon: new Icon(Icons.face, color: Colors.green),
                      iconSize: _actionIconSize,
                      onPressed: () {
                        _onEmotionStateSelected(false, Emotion.happy);
                      },
                    ),
                  ),
                  new Expanded(
                    child: new IconButton(
                      icon: new Icon(Icons.face, color: Colors.orange),
                      iconSize: _actionIconSize,
                      onPressed: () {
                        _onEmotionStateSelected(false, Emotion.normal);
                      },
                    ),
                  ),
                  new Expanded(
                    child: new IconButton(
                      icon: new Icon(Icons.face, color: Colors.red),
                      iconSize: _actionIconSize,
                      onPressed: () {
                        _onEmotionStateSelected(false, Emotion.sad);
                      },
                    ),
                  ),
                ],
              )
            : new Container(),
        new Flexible(
          child: new Container(
              margin: new EdgeInsets.only(left: 20.0, right: 20.0),
              child: new Center(
                  heightFactor: 4.0,
                  child: new TextField(
                    focusNode:_emotionTextInputFocusNode,
                    style: new TextStyle(
                      fontSize: 18.0,
                      color: Colors.black54,
                      fontFamily: "jose",
                    ),
                  ))),
        ),
      ]),
    );
  }

  void _onEmotionStateSelected(bool visibility, Emotion emotion) {
    setState((){      
      _emotionIconsVisible  = false;
      _questionTextFontSize = 20.0;

      if (emotion == Emotion.happy) {
        _questionText = "That's great ! Why do you feel like that?";
      } else if (emotion == Emotion.normal) {
        _questionText = "That's ok... Why do you feel like that?";
      } else {
        _questionText = "That's sad :(  Why do you feel like that?";
      }
      FocusScope.of(context).requestFocus(_emotionTextInputFocusNode);
    });
  }

  //todo route to next page
   /*_routeToSummaryPage(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }*/
}
