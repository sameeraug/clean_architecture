import 'package:clean_architecture/clean_architecture.dart';
import 'package:get_it/get_it.dart';

abstract class UseCase<T extends Entity> {
  void setViewModel(Object viewModel);
  void buildViewModel(T entity);

  late RepoScope<T> _scope;
  late T entity;
  void onEntityUpdated(T entity){}

  T initializeEntity(
  {required T defaultEntity,required GetIt locator,  required Function(T) onEntityUpdate}) {
    _scope = locator<Repo>()
        .create<T>(defaultEntity, onEntityUpdate, deleteIfExists: false);
    entity = locator<Repo>().get<T>(_scope);
    locator<Repo>().update(_scope, entity);
    return entity;
  }

  RepoScope<Entity>? getScope<T extends Entity>(GetIt locator) =>
      locator<Repo>().containsScope<T>();
}
