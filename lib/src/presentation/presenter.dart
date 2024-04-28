import 'package:clean_architecture/clean_architecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

abstract class Presenter<U extends UseCase, V extends ViewModel>
    extends StatefulWidget {
  final U useCase;
  final V viewModel;
  final bool? reactive;

  Widget buildScreen(BuildContext context, U useCase, V viewModel,
      SizingInformation sizingInfo);

  void onWidgetLoaded(BuildContext context, U useCase, V viewModel);

  void onViewModelCreated(BuildContext context, U useCase, V viewModel);

  void dispose();

  void initState(){}

  @override
  State<Presenter<U, V>> createState() =>
      _PresenterState<U, V>(useCase, viewModel);

  Presenter(this.useCase, this.viewModel, {this.reactive = true});


}

class _PresenterState<U extends UseCase, V extends ViewModel>
    extends State<Presenter<U, V>> {
  late final V _viewModel;
  late final U _useCase;

  V get viewModel => _viewModel;

  U get useCase => _useCase;

  _PresenterState(this._useCase, this._viewModel) {
    _useCase.setViewModel(viewModel);
  }

  @override
  void initState() {
    widget.initState();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    widget.dispose();
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
