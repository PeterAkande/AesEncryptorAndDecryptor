import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

Color getButtonColor(BuildContext context) {
  //This would give the button color depending on the mode of the app. Dark or light

  bool darkMode =
      MediaQuery.of(context).platformBrightness == Brightness.dark;

  if (darkMode) {
    return darkModeButtonColor;
  } else {
    return lightModeButtonColor;
  }
}

Color getButtonSelectedColor(BuildContext context) {
  //This would give the button color when selected depending on the mode of the app. Dark or light

  bool darkMode =
      MediaQuery.of(context).platformBrightness == Brightness.dark;

  if (darkMode) {
    return darkModeButtonSelected;
  } else {
    print('omo');
    return lightModeButtonSelected;
  }
}