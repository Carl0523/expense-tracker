import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xff516AD6),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Colors.black,
);

class MyTheme
{
  static final darkTheme = ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kDarkColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: Colors.grey.shade800,
        foregroundColor: const Color(0xFFD3DBFF),
        actionsIconTheme: const IconThemeData().copyWith(color: Colors.white),
      ),
      dropdownMenuTheme: const DropdownMenuThemeData().copyWith(
        inputDecorationTheme: const InputDecorationTheme().copyWith(

        ),
      ),
      cardTheme: const CardTheme().copyWith(
        color: const Color(0xff516AD6),
        margin: const EdgeInsets.symmetric(
          vertical: 8,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkColorScheme.primaryContainer,
          foregroundColor: kDarkColorScheme.onPrimaryContainer,
        ),
      ),
      textTheme: ThemeData().textTheme.copyWith(
            bodyMedium: TextStyle(color: kDarkColorScheme.secondary),
          ),
    );

    static final lightTheme = ThemeData.light().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.primary,
          foregroundColor: const Color(0xFFD3DBFF),
          actionsIconTheme: const IconThemeData().copyWith(color: Colors.white),
        ),
        cardTheme: const CardTheme().copyWith(
          color: const Color(0xffE9ECFB),
          margin: const EdgeInsets.symmetric(
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primary,
            foregroundColor: const Color(0xFFD3DBFF),
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              bodyMedium: const TextStyle(color: Colors.black),
            ),
      );
}