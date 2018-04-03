import 'dart:async';
import 'package:flutter/material.dart';
import 'home_presenter.dart';

enum Emotion { happy, normal, sad }

enum ViewState { inputState, selectionState }

class HomePage extends StatefulWidget {
  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HomePage> implements HomePageContract {
  HomePagePresenter _presenter;

  TextEditingController _inputController;
  FocusNode _emotionTextInputFocusNode;

  double _actionIconSize;
  double _questionTextFontSize;
  bool _emotionIconsEnabled;
  String _questionText;
  String _currentEmotionState;

  @override
  void initState() {
    super.initState();

    _presenter = new HomePagePresenter(this);
    _emotionIconsEnabled = true;
    _actionIconSize = 85.0;
    _questionTextFontSize = 25.0;
    _questionText = "How are you today ?";
    _emotionTextInputFocusNode = new FocusNode();
    _emotionTextInputFocusNode.addListener(_onFocusChange);
    _inputController = new TextEditingController();
  }

  Future<bool> _onWillPop() async {
    if (_emotionIconsEnabled) {
      return true;
    } else {
      _onStateChanged(ViewState.selectionState);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
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
                    color: Colors.black87,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            _emotionIconsEnabled
                ? new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new IconButton(
                          icon: new Icon(Icons.sentiment_satisfied,
                              color: Colors.green),
                          iconSize: _actionIconSize,
                          onPressed: () {
                            _onStateChanged(
                                ViewState.inputState, context, Emotion.happy);
                          },
                        ),
                      ),
                      new Expanded(
                        child: new IconButton(
                          icon: new Icon(Icons.sentiment_neutral,
                              color: Colors.orange),
                          iconSize: _actionIconSize,
                          onPressed: () {
                            _onStateChanged(
                                ViewState.inputState, context, Emotion.normal);
                          },
                        ),
                      ),
                      new Expanded(
                        child: new IconButton(
                          icon: new Icon(Icons.sentiment_dissatisfied,
                              color: Colors.red),
                          iconSize: _actionIconSize,
                          onPressed: () {
                            _onStateChanged(
                                ViewState.inputState, context, Emotion.sad);
                          },
                        ),
                      ),
                    ],
                  )
                : new Container(),
            new Flexible(
              child: new AnimatedOpacity(
                opacity: !_emotionIconsEnabled ? 1.0 : 0.0,
                duration: new Duration(milliseconds: 300),
                child: new Container(
                    margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                    child: new Center(
                        heightFactor: 3.0,
                        child: new TextField(
                          focusNode: _emotionTextInputFocusNode,
                          controller: _inputController,
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                              fontSize: 16.0,
                              // color: Colors.black54,
                              // fontFamily: "jose",
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                              textBaseline: TextBaseline.ideographic),
                          decoration: new InputDecoration(
                            prefixIcon: new Icon(Icons.create),
                            isDense: true,
                          ),
                        ))),
              ),
            ),
            new Flexible(
              child: new AnimatedOpacity(
                opacity: !_emotionIconsEnabled ? 1.0 : 0.0,
                duration: new Duration(milliseconds: 500),
                child: new Container(
                  child: new RaisedButton.icon(
                    icon: new Icon(
                      Icons.done,
                      color: Colors.lightGreen,
                      size: 30.0,
                    ),
                    label: new Text(
                      "submit answer",
                      style: new TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 14.0,
                        color: Colors.black87,
                        fontFamily: "jose",
                      ),
                    ),
                    color: Colors.orangeAccent,
                    elevation: 4.0,
                    splashColor: Colors.blueGrey,
                    highlightColor: Colors.yellowAccent,
                    onPressed: () {
                      onSubmit();
                    },
                  ),
                ),
              ),
            ),
          ]),
        ));
  }

  void _onStateChanged(ViewState viewState,
      [BuildContext buildContext, Emotion emotion]) {
    setState(() {
      if (viewState == ViewState.inputState) {
        _setAsInputState(emotion, buildContext);
      } else {
        _setAsSelectionState();
      }
    });
  }

  void _setAsInputState(Emotion emotion, BuildContext buildContext) {
    _emotionIconsEnabled = false;
    _questionTextFontSize = 20.0;

    if (emotion == Emotion.happy) {
      _questionText = "That's great ! Why do you feel like that?";
    } else if (emotion == Emotion.normal) {
      _questionText = "That's ok... Why do you feel like that?";
    } else {
      _questionText = "That's sad :(  Why do you feel like that?";
    }
    _currentEmotionState = emotion.toString();

    FocusScope.of(buildContext).requestFocus(_emotionTextInputFocusNode);
  }

  void _setAsSelectionState() {
    _emotionIconsEnabled = true;
    _questionText = "How are you today ?";
    _emotionTextInputFocusNode.unfocus();
    _questionTextFontSize = 25.0;
    _inputController.clear();
  }

  void _onFocusChange() {
    if (_emotionIconsEnabled) _emotionTextInputFocusNode.unfocus();
  }

  @override
  void onSubmit() {
    _presenter.insertEmotionState(_inputController.text, _currentEmotionState);
  }

  @override
  void dispose() {
    _emotionTextInputFocusNode.removeListener(_onFocusChange);
    super.dispose();
  }
}
