
abstract class HomePageContract {
  void onSubmit();
}

class HomePagePresenter {
  HomePageContract _view;
  HomePagePresenter(this._view);

  insertEmotionState(String emotionMessage, String emotionStates) {
    //todo get timestamp
    //send to database
  }
}
