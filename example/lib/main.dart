import 'dart:async';
import 'package:example/features/home/ui/feature_home.dart';
import 'package:example/root_screen.dart';
import 'package:flutter/material.dart';
import 'locator.dart';

void main() {
  runProdApp(Widget defaultHome) {
    WidgetsFlutterBinding.ensureInitialized();
    runApp( const MyApp());
  }
  preMainSetup(runProdApp);
}

Future<void> preMainSetup(Function runConfiguredApp) async {
  await setupLocator();
  Widget defaultHome = const RootScreen();
  runZonedGuarded(() => runConfiguredApp(defaultHome), (error, stackTrace) {
    debugPrint('runZonedGuarded - Caught exception in root');
    debugPrint(error.toString());
    debugPrint(stackTrace.toString());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeFeature(),
    );
  }
}

