import 'package:flutter/material.dart';

class Themes {
  static ThemeData darkMode() {
    return ThemeData(
      brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          brightness: Brightness.dark,
        ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.redAccent,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black38,
        selectedItemColor: Colors.redAccent,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: false,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black38,
      ),
    );
  }

  static ThemeData lightMode() {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.purple,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.purple,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: false,
      ),
    );
  }
}