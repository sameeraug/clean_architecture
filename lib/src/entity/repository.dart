import 'package:clean_architecture/src/entity/entity.dart';

typedef RepositorySubscription<T> = void Function(T);

class RepoScope<E extends Entity> {
  RepositorySubscription<E> notifyEntity;

  RepoScope(this.notifyEntity);
}

class Repo {
  final Map<RepoScope, Entity> _scopes = {};

  RepoScope<E> create<E extends Entity>(
    E entity,
    RepositorySubscription<E> subscription, {
    bool deleteIfExists = false,
  }) {
    for (final scope in _scopes.keys) {
      if (_scopes[scope] is E) {
        if (deleteIfExists) {
          _scopes.remove(scope);
        } else {
          final _scope = scope as RepoScope<E>;
          scope.notifyEntity = subscription;
          return _scope;
        }
        break;
      }
    }

    final scope = RepoScope(subscription);
    _scopes[scope] = entity;
    return scope;
  }

  void update<E extends Entity>(RepoScope scope, E entity) {
    if (_scopes[scope] == null) throw _entityNotFound;
    _scopes[scope] = entity;
  }

  E get<E extends Entity>(RepoScope scope) {
    final entity = _scopes[scope];

    if (entity == null) throw _entityNotFound;
    return entity as E;
  }

  //   checks if scope exists

  RepoScope<Entity>? containsScope<E extends Entity>() {
    for (final scope in _scopes.entries) {
      if (scope.value is E) return scope.key;
    }
    return null;
  }

  Never get _entityNotFound => throw StateError('Entity Not Found');

  //   deletes the existing entity in scope

  void delete<E extends Entity>(RepoScope scope) {
    if (_scopes[scope] == null) throw _entityNotFound;
    _scopes.remove(scope);
  }
}
