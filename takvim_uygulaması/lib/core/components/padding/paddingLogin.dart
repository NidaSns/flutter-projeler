import 'package:flutter/material.dart';

class PaddingLoginWdgt {
  static PaddingLoginWdgt instance = PaddingLoginWdgt._init();

  PaddingLoginWdgt._init();

  Padding showPadding(double height, double width, TextField textField) {
    return Padding(
      padding: EdgeInsets.only(
        left: width,
        right: width,
        top: height,
        bottom: 0,
      ),
      child: textField,
    );
  }
}
