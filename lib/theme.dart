import 'package:flutter/material.dart';

themeData() {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepPurple,
      elevation: 5,
      titleTextStyle: TextStyle(
        fontSize: 26,
      ),
      centerTitle: true,
    ),
    primarySwatch: Colors.deepPurple,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      background: Colors.white70,
      error: Colors.red,
      secondary: Colors.deepOrange
    ),
    primaryColor: Colors.deepPurple,
    fontFamily: 'Lato',
    iconTheme: const IconThemeData(
      color: Colors.red,
    ),
    useMaterial3: true,
  );
}
