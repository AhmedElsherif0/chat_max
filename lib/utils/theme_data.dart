import 'package:flutter/material.dart';

class CustomThemeData {
  ThemeData themeData(context) {
    return ThemeData(
        primarySwatch: Colors.lightBlue,
        backgroundColor: Colors.lightBlue,
        accentColor: Colors.indigo,
        accentColorBrightness: Brightness.dark,
        buttonTheme: buttonThemes(context),
        primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white)));
  }
}

ButtonThemeData buttonThemes(BuildContext context) {
  return ButtonTheme.of(context).copyWith(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );
}
