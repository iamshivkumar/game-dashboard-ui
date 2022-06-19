import 'package:flutter/material.dart';

class Pallate {
  static const Color red = Color(0xFFF04B5A);
  static Color get redLayer => red.withOpacity(0.2);
  static const Color teal = Colors.teal;
  static Color get tealLayer => teal.withOpacity(0.2);
  static Color get deepPurple => Colors.deepPurpleAccent.shade700;
  static Color get deepPurpleLayer => Colors.deepPurpleAccent.shade700.withOpacity(0.1);
}
