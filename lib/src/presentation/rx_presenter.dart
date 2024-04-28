import 'package:clean_architecture/clean_architecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

abstract class RxPresenter<U extends UseCase, V extends RxViewModel>
    extends StatefulWidget {
  final U useCase;
  final V viewModel;
  final bool? reactive;

  Widget buildScreen(BuildContext context, U useCase, V viewModel,
      SizingInformation sizingInfo);

  void onWidgetLoaded(BuildContext context, U useCase, V viewModel);

  void onViewModelCreated(BuildContext context, U useCase, V viewModel);
  @override
  State<RxPresenter<U, V>> createState() =>
      _RxPresenterState<U, V>(useCase, viewModel);

  RxPresenter(this.useCase, this.viewModel, {this.reactive = true});
}

class _RxPresenterState<U extends UseCase, V extends RxViewModel>
    extends State<RxPresenter<U, V>> {
  late final V _viewModel;
  late final U _useCase;

  V get viewModel => _viewModel;

  U get useCase => _useCase;

  _RxPresenterState(this._useCase, this._viewModel) {
    _useCase.setViewModel(viewModel);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      widget.onWidgetLoaded(context, useCase, viewModel);
    });
    if (widget.reactive ?? false) {
      return ViewModelBuilder<V>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) =>
            widget.onViewModelCreated(context, useCase, viewModel),
        builder: (context, viewModel, child) =>
            buildResponsiveScreen(context, useCase, viewModel),
      );
    } else {
      return ViewModelBuilder<V>.nonReactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) =>
            widget.onViewModelCreated(context, useCase, viewModel),
        builder: (context, viewModel, child) =>
            buildResponsiveScreen(context, useCase, viewModel),
      );
    }
  }

  Widget buildResponsiveScreen(context, useCase, viewModel) {
    return ResponsiveBuilder(
        builder: (context, sizingInfo) =>
            widget.buildScreen(context, useCase, viewModel, sizingInfo));
  }
}
