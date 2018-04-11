import '../../data/database/app_database_helper.dart';
import '../base/base_contract.dart';
import '../base/base_presenter.dart';

abstract class SummaryPageContract implements BaseContract {
  void onUserStateReceived(List<Map<String, dynamic>> userState);
}

class SummaryPagePresenter extends BasePresenter {
  SummaryPageContract _view;
  SummaryPagePresenter(this._view);
  void retrieveUserState() async {
    var stateMap = await AppDatabaseHelper.internal().retrieveUserState();
    _view.onUserStateReceived(stateMap);
  }
}
