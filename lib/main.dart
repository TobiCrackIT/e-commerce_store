import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mistore/home.dart';
import 'package:provider/provider.dart';
import 'model/app_state_model.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
      ChangeNotifierProvider<AppStateModel>(
          create: (context) => AppStateModel()..loadProducts(),
          child: MistoreApp()
      )
  );
}

class MistoreApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.white,
          cursorColor: Colors.deepPurple,
          indicatorColor: Colors.deepPurple),
      home: Home(),
    );
  }
}
