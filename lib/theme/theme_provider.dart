import 'package:flutter/material.dart';
import 'package:notes_app_2/theme/theme.dart';

class ThemeProvider with ChangeNotifier{
  // initial theme
  ThemeData _themeData = lightMode;
  // getter to access the theme in other parts of the code
  ThemeData get themeData => _themeData;
  // getter to see if we are in dark mode or not
  bool get isDarkMode => _themeData == darkMode;

  // setter to get the new theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // used on switch button
  void toggleTheme(){
    if(_themeData == lightMode){
      themeData = darkMode;
    }else{
      themeData = lightMode;
    }
  }

}