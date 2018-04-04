import '../../data/database/app_database_helper.dart';
import '../../data/database/model/user_state.dart';

abstract class HomePageContract {
  void onSubmitSuccess();
  void onSubmitError(String error);
}

class HomePagePresenter {
  HomePageContract _view;
  HomePagePresenter(this._view);

  void insertEmotionState(String emotionMessage, String emotionState) async {
    var userState = new UserState(
        emotionMessage, emotionState, new DateTime.now().toString());
    AppDatabaseHelper.internal().saveUserState(userState).then((v) {
     // _view.onSubmitSuccess();
    }).catchError((onError) => _view.onSubmitError(onError.toString()));



    var test = AppDatabaseHelper.internal().retrieveUserState();
    var hmm = 1;
  }
}
