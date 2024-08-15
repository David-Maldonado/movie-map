import 'package:flutter/material.dart';

// Una clase con un metodo que devuelve la configuracion inicial
class AppTheme {
  ThemeData getTheme() =>
      ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xff003554));
}
