import 'package:flutter/material.dart';
import '../../data/database/tables.dart';
import '../base/presenter_factory_producer.dart';
import '../common/components.dart/app_bar.dart';
import 'summary_page_presenter.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class SummaryPage extends StatefulWidget {
  @override
  State createState() => new SummaryPageState();
}

class SummaryPageState extends State<SummaryPage>
    implements SummaryPageContract {
  AppBarComponent appBarComponent = new AppBarComponent();
  SummaryPagePresenter _presenter;
  List<Entry> data; //todo

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _presenter =
        PresenterFactoryProducer.getPresenter(ViewType.summaryScreen, this);

    _presenter.retrieveUserState();
  }

//todo sort state out
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: appBarComponent.getComponent(),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) =>
            new EntryItem(data[index], context),
      ),
    );
  }

  @override
  void onUserStateReceived(List<Map<String, dynamic>> userState) {
    this.setState(() {
      buildStateList(userState);
    });
  }

  void buildStateList(List<Map<String, dynamic>> userStates) {
    data = new List<Entry>();

    for (int i = 0; i < userStates.length; i++) {
      var map = userStates[i];
      var emotionState = map[UserTable.emotionStateCol] as String;
      var emotionMessage = map[UserTable.emotionMessageCol] as String;
      var timeStamp = map[UserTable.emotionTimeStampCol] as String;
      var inner = new List<Entry>();

      inner.add(new Entry(emotionMessage, emotionState));
      var entry = new Entry(timeStamp, emotionState, inner);
      data.add(entry);
    }
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, this.emotionState, [this.children = const <Entry>[]]);
  final String title;
  final List<Entry> children;
  String emotionState;

  Tuple2<IconData, MaterialColor> stateIcon() {
    if (emotionState == "Emotion.happy") {
      return new Tuple2<IconData, MaterialColor>(
          Icons.sentiment_satisfied, Colors.green);
    } else if (emotionState == "Emotion.normal") {
      return new Tuple2<IconData, MaterialColor>(
          Icons.sentiment_neutral, Colors.orange);
    } else {
      return new Tuple2<IconData, MaterialColor>(
          Icons.sentiment_dissatisfied, Colors.red);
    }
  }
}

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry, this.context);

  final Entry entry;
  final BuildContext context;

  Widget _buildTiles(Entry root) {
    var stateIcon = root.stateIcon();

    if (root.children.isEmpty)
      return new ListTile(
          title: new Text(
            root.title,
            style: new TextStyle(fontSize: 15.0, color: Colors.black54),
          ),
          // onTap: ()=>debugPrint("I was clicked"),
          trailing: new IconButton(
            icon: new Icon(
              Icons.delete_forever,
              size: 30.0,
              color: Colors.black,
            ),
            onPressed: () => showAlertDialog(context),
          ));
    return new ExpansionTile(
        key: new PageStorageKey<Entry>(root),
        title: new Text(
          root.title,
          style: new TextStyle(
              fontSize: 18.0, fontFamily: "jose", color: Colors.black87),
        ),
        leading: new Icon(stateIcon.item1, color: stateIcon.item2 , size: 35.0,) ,
        children: root.children.map(_buildTiles).toList(),
        backgroundColor: Colors.white70);
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }

  void showAlertDialog(BuildContext context) {
    AlertDialog dialog = new AlertDialog(
      content: new Text(
        "Would you like to delete this entry?",
        style: new TextStyle(
          fontFamily: "roboto",
          fontSize: 16.0,
          color: Colors.black87,
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        new FlatButton(
          child: const Text("Ok"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }
}
