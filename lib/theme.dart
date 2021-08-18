import 'package:flutter/material.dart';
import 'package:message_sent_app/constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: contentColorDarkTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: contentColorDarkTheme,
        elevation: 0,
      ),
      colorScheme: ColorScheme.dark(),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              padding:
                  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(secondaryColorDarkTheme))));
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: contentColorLightTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: contentColorLightTheme,
        elevation: 0,
      ),
      colorScheme: ColorScheme.light(),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              padding:
                  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(secondaryColorLightTheme))),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))));
}
