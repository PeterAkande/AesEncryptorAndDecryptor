import 'package:aes_encryptor_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Would change all these later.
class AesEncryptorTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: lightModeTextColor,
    ),
    headline1: GoogleFonts.openSans(
      fontSize: 29.0,
      fontWeight: FontWeight.bold,
      color: lightModeTextColor,
    ),
    headline2: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: lightModeTextColor,
    ),
    //headline 3 would be used for the selected button colors
    headline3: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: darkModeTextColor,
    ),
    headline6: GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: lightModeTextColor,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: darkModeTextColor,
    ),
    headline1: GoogleFonts.openSans(
      fontSize: 29.0,
      fontWeight: FontWeight.bold,
      color: darkModeTextColor,
    ),
    headline2: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: darkModeTextColor,
    ),
    //Selected color stuffs
    headline3: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w600,
      color: lightModeTextColor,
    ),
    headline6: GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: darkModeTextColor,
    ),
  );

  static ThemeData light() {
    return ThemeData(
      primaryColor: const Color(0xFFf5efec),
      brightness: Brightness.light,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) {
          return Colors.black;
        }),
      ),
      appBarTheme: const AppBarTheme(
        //foregroundColor: Colors.white,
        backgroundColor: Colors.white,

        iconTheme: IconThemeData(color: Colors.black),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.red,
        // unselectedItemColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      textTheme: lightTextTheme,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      primaryColor: const Color(0xFF22223B),
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: darkTextTheme,
    );
  }
}
