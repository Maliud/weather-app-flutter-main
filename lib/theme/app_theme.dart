
import 'package:flutter/material.dart';
import 'package:weather_app_flutter_main/theme/pallete.dart';


class AppTheme {
  static ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: PalleteDark.primaryColor,
      onPrimary: PalleteDark.primaryColor,
      secondary: PalleteDark.secondaryColor,
      onSecondary: PalleteDark.secondaryColor,
      error: Colors.red,
      onError: Colors.red,
      background: Colors.white30,
      onBackground: PalleteDark.secondaryColor,
      surface: Colors.black54,
      onSurface: Colors.black12,
    ),
    scaffoldBackgroundColor: PalleteDark.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: PalleteDark.primaryColor,
      elevation: 0,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: PalleteDark.primaryColor,
    ),
    iconTheme: const IconThemeData(
      color: PalleteDark.activeTextColor,
    ),
    tabBarTheme: TabBarTheme(
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: const LinearGradient(
          colors: [
            PalleteDark.gradiantFromColor,
            PalleteDark.gradiantToColor,
          ],
        ),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: const TextStyle(
        fontFamily: "Poppins",
        color: PalleteDark.activeTextColor,
        fontSize: 70,
      ),
      headlineLarge: const TextStyle(
        fontFamily: "Poppins",
        color: PalleteDark.activeTextColor,
        fontSize: 25,
      ),
      bodyLarge: const TextStyle(
        fontFamily: "Poppins",
        color: PalleteDark.activeTextColor,
        fontSize: 18,
      ),
      bodyMedium: const TextStyle(
        fontFamily: "Poppins",
        color: PalleteDark.activeTextColor,
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        fontFamily: "Poppins",
        color: PalleteDark.inactiveTextColor,
        fontSize: 12,
      ),
    ),
  );

  static ThemeData lightTheme = ThemeData.dark(useMaterial3: true).copyWith(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: PalleteLight.primaryColor,
      onPrimary: PalleteLight.primaryColor,
      secondary: PalleteLight.secondaryColor,
      onSecondary: PalleteLight.secondaryColor,
      error: Colors.red,
      onError: Colors.red,
      background: PalleteLight.secondaryColor,
      onBackground: PalleteLight.secondaryColor,
      surface: Color(0xffcbc0d3),
      onSurface: PalleteLight.gradiantToColor,
    ),
    scaffoldBackgroundColor: PalleteLight.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: PalleteLight.primaryColor,
      elevation: 0,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: PalleteLight.primaryColor,
    ),
    iconTheme: const IconThemeData(
      color: PalleteLight.iconColor,
    ),
    tabBarTheme: TabBarTheme(
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: const LinearGradient(
          colors: [
            PalleteLight.gradiantFromColor,
            PalleteLight.gradiantToColor,
          ],
        ),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: const TextStyle(
        fontFamily: "Poppins",
        color: PalleteLight.activeTextColor,
        fontSize: 70,
      ),
      headlineLarge: const TextStyle(
        fontFamily: "Poppins",
        color: PalleteLight.activeTextColor,
        fontSize: 25,
      ),
      bodyLarge: const TextStyle(
        fontFamily: "Poppins",
        color: PalleteLight.activeTextColor,
        fontSize: 18,
      ),
      bodyMedium: const TextStyle(
        fontFamily: "Poppins",
        color: PalleteLight.activeTextColor,
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        fontFamily: "Poppins",
        color: PalleteLight.inactiveTextColor,
        fontSize: 12,
      ),
    ),
  );
}
