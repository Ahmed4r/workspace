import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static final label = TextStyle(fontSize: 10, fontWeight: FontWeight.w500);
  static final cellPrimary = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );
  static final cellSecondary = TextStyle(fontSize: 11, fontFamily: 'monospace');
  static final sectionTitle = TextStyle(fontWeight: FontWeight.w700);
}
