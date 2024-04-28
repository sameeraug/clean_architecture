import 'package:clean_architecture/clean_architecture.dart';
import 'package:example/locator.dart';
import '../model/entity_home.dart';
import '../model/view_model_home.dart';

class HomeUseCase extends UseCase<HomeEntity> {
  late RepoScope<HomeEntity> homeEntityScope;
  late HomeEntity homeEntity;
  late HomeViewModel _homeViewModel;

   @override
  void setViewModel(Object viewModel) {
    _homeViewModel = viewModel as HomeViewModel;
    homeEntity = initializeEntity(
        defaultEntity: const HomeEntity(counter: 0, myCounter: 'test'),
        locator: locator,
        onEntityUpdate: onEntityUpdate);
    homeEntityScope = getScope<HomeEntity>(locator)! as RepoScope<HomeEntity>;
  }

  @override
  void buildViewModel(HomeEntity entity) {
    locator<Repo>().update(homeEntityScope, entity);
    _homeViewModel.counter = entity.counter;
    _homeViewModel.notifyViewModel();
  }

  onEntityUpdate(HomeEntity homeEntity) {}

  Future updateCounter() async {
    homeEntity = homeEntity.copyWith(counter: homeEntity.counter + 1);
    buildViewModel(homeEntity);
  }
}
