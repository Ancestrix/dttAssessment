import 'package:flutter/material.dart';

class ThemeMethod{

// Define the theme data for the app
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    color: Colors.transparent,
    shadowColor: Colors.transparent,
  ),
);

final lightTheme = ThemeData(
  textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 12,
          color: Color(0x66000000),
          fontFamily: "Gotham SSm-Book"),
      headline2: TextStyle(color: Color(0xffF02E65))),
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    color: Colors.transparent,
    shadowColor: Colors.transparent,
  ),
);


}