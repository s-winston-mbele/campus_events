import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const ink = Color(0xFF080D23);
  static const muted = Color(0xFF747A91);
  static const teal = Color(0xFF084F49);
  static ThemeData get light => ThemeData(
    useMaterial3: true, fontFamily: 'Modern',
    scaffoldBackgroundColor: const Color(0xFFF7F9FC),
    colorScheme: ColorScheme.fromSeed(seedColor: teal).copyWith(
      primary: teal, surface: Colors.white, onSurface: ink),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(fontSize: 21, fontWeight: FontWeight.w700, color: ink),
      titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: ink),
      bodyMedium: TextStyle(fontSize: 12, color: muted, height: 1.5)),
    filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(
      backgroundColor: teal, foregroundColor: Colors.white,
      minimumSize: const Size(100, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, fillColor: Colors.white,
      hintStyle: const TextStyle(color: muted, fontSize: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18))));
}
