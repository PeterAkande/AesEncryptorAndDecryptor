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

TextStyle? getTextSelectedStyle(BuildContext context) {
  //This would give the text color when selected depending on the mode of the app. Dark or light

  bool darkMode =
      MediaQuery.of(context).platformBrightness == Brightness.dark;

  if (darkMode) {
    return Theme.of(context)
        .textTheme
        .headline2
        ?.copyWith(color: lightModeTextColor, fontSize: 17);
  } else {

    return Theme.of(context)
        .textTheme
        .headline2
        ?.copyWith(color: Colors.white, fontSize: 17);
  }
}