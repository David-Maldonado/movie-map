import 'package:flutter/material.dart';

// Una clase con un metodo que devuelve la configuracion inicial
class AppTheme {
  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: const Color.fromARGB(214, 109, 14, 1));
}
