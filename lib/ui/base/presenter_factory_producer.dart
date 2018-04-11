import '../home/home_page_presenter.dart';
import '../summary/summary_page_presenter.dart';
import 'base_contract.dart';
import 'base_presenter.dart';


enum ViewType { homeScreen, summaryScreen }

class PresenterFactoryProducer {


  static BasePresenter getPresenter(ViewType viewType , BaseContract contract){
    if (viewType == ViewType.homeScreen) {
      return new HomePagePresenter(contract);
    } else if (viewType == ViewType.summaryScreen) {
      return new SummaryPagePresenter(contract);
    }

    else throw new UnimplementedError("Impmnet bew presnter");
  }

}
