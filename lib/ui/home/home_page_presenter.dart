import '../../data/database/app_database_helper.dart';
import '../../data/database/model/user_state.dart';
import '../base/base_contract.dart';
import '../base/base_presenter.dart';
import 'package:intl/intl.dart';

abstract class HomePageContract implements BaseContract {
  void onSubmitSuccess();
  void onSubmitError(String error);
}

class HomePagePresenter extends BasePresenter {
  HomePageContract _view;

  HomePagePresenter(this._view);

  void insertEmotionState(String emotionMessage, String emotionState) async {
    var now = new DateTime.now();
    var formatter = new DateFormat("MMMM dd, yyyy : HH:mm");
    String timeStamp = formatter.format(now);

    var userState = new UserState(emotionMessage, emotionState, timeStamp);
    AppDatabaseHelper.internal().saveUserState(userState).then((v) {
      _view.onSubmitSuccess();
    }).catchError((onError) => _view.onSubmitError(onError.toString()));
  }
}
