import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhatsNextTheme{
  static TextTheme lightTextTheme = TextTheme (
      subtitle1: GoogleFonts.openSans( //Label del tabBar
          fontWeight: FontWeight.w700,
          fontSize: 16.0),
      bodyText1: GoogleFonts.openSans(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 14.0),
      bodyText2: GoogleFonts.openSans(
        fontSize: 14.0,
        fontWeight: FontWeight.w300,
        color: Colors.black,
      ),
      headline1: GoogleFonts.openSans( //Titulo de la AppBar
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold),
      headline6: GoogleFonts.openSans(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
  );

  static TextTheme darkTextTheme = TextTheme (
      subtitle1: GoogleFonts.openSans( //Label del tabBar
          fontWeight: FontWeight.w700,
          fontSize: 16.0),
      bodyText1: GoogleFonts.openSans(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14.0),
      bodyText2: GoogleFonts.openSans(
        fontSize: 14.0,
        fontWeight: FontWeight.w300,
        color: Color.fromARGB(255, 156, 168, 177),
      ),
      headline1: GoogleFonts.openSans( //Titulo de la AppBar
          color: Color.fromARGB(255, 156, 168, 177),
          fontSize: 20.0,
          fontWeight: FontWeight.bold),
      headline6: GoogleFonts.openSans(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 156, 168, 177),
      ),
  );

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) {
          return Colors.black;
        }),
      ),
      tabBarTheme:    TabBarTheme(
        indicator: BoxDecoration(
          color: Colors.white.withOpacity(0.0),
          border: Border(bottom: BorderSide(color: Colors.white, width: 2.0))
        ),
        unselectedLabelColor: Color.fromARGB(150,255, 255, 255),
        labelColor: Color.fromARGB(255,255, 255, 255),
        labelStyle: lightTextTheme.subtitle1,
        unselectedLabelStyle: lightTextTheme.subtitle1,
      ),
      appBarTheme:    AppBarTheme(
        titleTextStyle: lightTextTheme.headline1,
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 0, 128, 105),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 0, 128, 105),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 128, 105)),
          textStyle: MaterialStateProperty.all(lightTextTheme.subtitle2,)
        ),
      ),
      timePickerTheme: TimePickerThemeData(
        // backgroundColor:Color.fromARGB(255, 0, 128, 105),
        hourMinuteTextColor: Color.fromARGB(255, 0, 128, 105),
        hourMinuteColor: Color.fromARGB(255, 250, 250, 250),
        dialBackgroundColor: Colors.white,
        dialTextColor: Colors.black,
        dialHandColor:Color.fromARGB(255, 0, 128, 105),
      ),
      textTheme: lightTextTheme,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      tabBarTheme:  TabBarTheme(
        unselectedLabelColor: Color.fromARGB(150,255, 255, 255),
        labelColor: Color.fromARGB(255, 90, 224, 192),
        labelStyle: darkTextTheme.subtitle1,
        unselectedLabelStyle: darkTextTheme.subtitle1,
      ),
      appBarTheme:  AppBarTheme(
        titleTextStyle: darkTextTheme.headline1,
        foregroundColor: Color.fromARGB(255, 156, 168, 177),
        backgroundColor: Color.fromARGB(255, 31, 44, 52),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 90, 224, 192),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 128, 105)),
          textStyle: MaterialStateProperty.all(darkTextTheme.subtitle2,)
        ),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor:Color.fromARGB(255, 66, 66, 66),
        hourMinuteColor: Color.fromARGB(255, 89, 89, 89),
        hourMinuteTextColor: Color.fromARGB(255, 90, 224, 192),
        dialBackgroundColor: Color.fromARGB(255, 89, 89, 89),
        dialTextColor: Colors.white,
        dialHandColor:Color.fromARGB(255, 90, 224, 192),
      ),
      textTheme: darkTextTheme,
    );
  }
}