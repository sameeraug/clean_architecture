import 'package:clean_architecture/clean_architecture.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
// final entity = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<Repo>(Repo());
}
