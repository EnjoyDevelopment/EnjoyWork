import '../tables.dart';

class UserState {
  String _emotionMessage;
  String _emotionState;
  String _timeStamp;

  UserState(this._emotionMessage, this._emotionState, this._timeStamp);

  UserState.map(Map map) {
    this._emotionMessage = map[UserTable.emotionMessageCol];
    this._emotionState = map[UserTable.emotionStateCol];
    this._timeStamp = map[UserTable.emotionTimeStampCol];
  }

  String get emotionmessage => _emotionMessage;
  String get emotionState => _emotionState;
  String get timestamp => _timeStamp;

  Map<String, dynamic> toMap() {
    var map = new Map<String, String>();
    map["emotionmessage"] = _emotionMessage;
    map["emotionState"] = _emotionState;
    map["timestamp"] = _timeStamp;
    return map;
  }
}
