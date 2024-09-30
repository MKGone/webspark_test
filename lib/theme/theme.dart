import 'package:flutter/material.dart';
import 'package:webspark_test/utils/constants.dart';

final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: background,
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 24),
    bodyMedium: TextStyle(fontSize: 16),
  ),
  appBarTheme: const AppBarTheme(
    color: blue,
    titleTextStyle: TextStyle(color: background, fontSize: 24),
    iconTheme: IconThemeData(color: background),
  ),
  iconTheme: const IconThemeData(color: gray),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: blue),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(blue),
      minimumSize: WidgetStateProperty.all(
        const Size.fromHeight(50),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(color: blueAccent, width: 2.0),
        ),
      ),
      foregroundColor: WidgetStateProperty.all(black),
    ),
  ),
);
