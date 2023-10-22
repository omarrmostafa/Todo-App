import 'package:flutter/material.dart';

class MyThemeData {
  static const Color Primary = Colors.blueAccent;
  static const Color mint = Color(0xFFDFECDB);
  static const Color darkColor = Colors.black54;
  static const Color yellowColor = Color(0xFFFACC1D);
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: mint,
    textTheme: const TextTheme(
        bodyLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFF242424)),
        bodyMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF242424)),
        titleSmall: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFF242424)),
        bodySmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: Color(0xFF242424))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels:false,
        showUnselectedLabels:false ,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Primary,
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
        )),
  );
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.transparent,
      primaryColor: darkColor,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: darkColor,
          onPrimary: Colors.white,
          secondary: yellowColor,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.transparent,
          onBackground: darkColor,
          surface: Colors.grey.shade300,
          onSurface: Colors.white),
      textTheme: const TextTheme(
          bodyLarge: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          bodyMedium: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
          titleSmall: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          bodySmall: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w300, color: yellowColor)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: darkColor,
          type: BottomNavigationBarType.shifting,
          unselectedItemColor: Colors.white,
          selectedItemColor: yellowColor,
          selectedLabelStyle: TextStyle(fontSize: 12),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
          )),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white, size: 30),
          elevation: 0.0,
          centerTitle: true));
}
