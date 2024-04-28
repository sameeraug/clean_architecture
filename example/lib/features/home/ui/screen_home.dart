import 'package:clean_architecture/clean_architecture.dart';
import 'package:example/features/home/model/view_model_home.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel;
  final GestureTapCallback onTap;
  final SizingInformation sizingInfo;

  const HomeScreen(
      {super.key,
      required this.viewModel,
      required this.onTap,
      required this.sizingInfo});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Counter Example',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: false,
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${viewModel.counter}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RawMaterialButton(
                    onPressed: onTap,
                    fillColor: Colors.blue,
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
