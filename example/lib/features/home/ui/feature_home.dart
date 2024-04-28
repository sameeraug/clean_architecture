import 'package:clean_architecture/clean_architecture.dart';
import 'package:flutter/material.dart';
import 'presenter_home.dart';

class HomeFeature extends Feature {
  const HomeFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePresenter();
  }
}
