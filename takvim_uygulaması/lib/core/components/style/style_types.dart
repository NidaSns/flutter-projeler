import 'package:flutter/material.dart';
import '../../constants/calendar_constants.dart';

class StyleTypes {
  static StyleTypes instance = StyleTypes._init();

  StyleTypes._init();

  yaziStyle() => TextStyle(
        fontFamily: CalendarConstants.instance.arial,
      );

  TextStyle textStyle(Color color, double fontSize, String fontFamily) {
    return TextStyle(color: color, fontSize: fontSize, fontFamily: fontFamily);
  }
}
