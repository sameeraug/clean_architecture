import 'package:clean_architecture/clean_architecture.dart';

abstract class RxViewModel<T> extends ReactiveViewModel {
  void notifyViewModel() {
    notifyListeners();
  }
}

/*

class InformationService with ReactiveServiceMixin { //1
  InformationService() {
    //3
    listenToReactiveValues([_postCount]);
  }

  //2
  ReactiveValue<int> _postCount = ReactiveValue<int>(initial: 0);
  int get postCount => _postCount.value;

  void updatePostCount() {
    _postCount.value++;
  }

  void resetCount() {
    _postCount.value = 0;
  }
}
class WidgetOneViewModel extends ReactiveViewModel {
  // You can use get_it service locator or pass it in through the constructor
  final InformationService _informationService = locator<InformationService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_informationService];
}*/
