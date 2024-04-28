import 'package:clean_architecture/clean_architecture.dart';

abstract class ViewModel<T> extends BaseViewModel {
  void notifyViewModel() {
    notifyListeners();
  }
}
