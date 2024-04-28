import 'package:clean_architecture/clean_architecture.dart';
import 'package:flutter/material.dart';
import '../model/view_model_home.dart';
import '../use_case/use_case_home.dart';
import 'screen_home.dart';

class HomePresenter extends Presenter<HomeUseCase, HomeViewModel> {
  HomePresenter() : super(HomeUseCase(), HomeViewModel());

  @override
  Widget buildScreen(BuildContext context, HomeUseCase useCase,
      HomeViewModel viewModel, SizingInformation sizingInfo) {

    return HomeScreen(
      viewModel: viewModel,
      sizingInfo: sizingInfo,
      onTap: () => useCase.updateCounter(),
    );
  }

  @override
  Future<void> onWidgetLoaded(BuildContext context, HomeUseCase useCase,
      HomeViewModel viewModel) async {}

  @override
  Future<void> onViewModelCreated(BuildContext context, HomeUseCase useCase,
      HomeViewModel viewModel) async {
    //  listenToFirebaseEvents(context);
    useCase.updateCounter().then((value) {});
  }

  @override
  void dispose() {}
}
