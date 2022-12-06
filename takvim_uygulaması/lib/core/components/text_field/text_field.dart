import 'package:flutter/material.dart';
import 'package:takvim_projesi/core/constants/calendarConstants.dart';

class TextFieldWdgt {
  static TextFieldWdgt instance = TextFieldWdgt._init();

  TextFieldWdgt._init();

  TextFormField showTextField(
    Key? key,
    String labelText,
    String hintText,
    TextStyle textStyle,
    bool gizliMi,
    String kaydedilecekDeger,
  ) {
    return TextFormField(
      key: key,
      obscureText: gizliMi,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
      ),
      style: textStyle,
      validator: (value) {
        if (value!.isEmpty || value.length < 4) {
          return CalendarConstants.instance.loginUyari;
        }
        return null;
      },
      onSaved: (value) {
        kaydedilecekDeger = value!;
      },
    );
  }
}
