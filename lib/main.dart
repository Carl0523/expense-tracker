import 'package:flutter/material.dart';
import 'package:expense_tracker/home.dart';
import 'package:expense_tracker/my_theme.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ],
  ).then(
    (fun) {
      runApp(
        MaterialApp(
          darkTheme: MyTheme.darkTheme,
          theme: MyTheme.lightTheme,
          home: const Home(),
          themeMode: ThemeMode.system,
        ),
      );
    },
  );
}
