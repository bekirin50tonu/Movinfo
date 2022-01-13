import 'package:flutter/material.dart';

class ThemeConstants {
  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.grey.shade500,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
  );

  static ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.grey,
      primaryColor: Colors.deepPurple,
      brightness: Brightness.light,
      backgroundColor: const Color(0xFFE5E5E5),
      accentColor: Colors.deepPurpleAccent,
      accentIconTheme: IconThemeData(color: Colors.white),
      dividerColor: Colors.white54,
      cardColor: Colors.grey[200],
      textTheme: TextTheme(headline6: TextStyle(color: Colors.black87)));
}
