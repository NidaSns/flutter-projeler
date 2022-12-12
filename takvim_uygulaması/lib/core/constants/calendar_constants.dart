import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../view/home/takvim/event.dart';

class CalendarConstants {
  static CalendarConstants instance = CalendarConstants._init();
  CalendarConstants._init();

  //Colors
  final appleBlossom = const Color(0xffb04b4b);
  final white = const Color(0xffFFFFFF);
  final blueGrey = const Color(0xff6699cc);
  final lightBlueAccent = const Color(0xffadd8e6);
  final pinkHot = const Color(0xffDA70D6);
  final red = const Color(0xffff0000);
  final blue = const Color(0xff0000FF);
  final black = const Color(0xff000000);
  final orangeAccent = const Color(0xffCD853F);
  final deepPurple = const Color(0xff6a0dad);
  final pinkAccent = const Color(0xffAA336A);
  final purpleAccent = const Color(0xff6a0dad);
  final darkCyan = const Color(0xff008B8B);
  final green = const Color(0xff008000);

  // texts
  final String homeTitle = 'Hoşgeldiniz';
  final String girisPasswordYz = 'Parola';
  final String girisButonYz = 'Giriş';
  final String girisSifreUnuttumYz = 'Şifremi Unuttum';
  final String girisMailYz = 'Email';
  final String arial = 'Arial';
  final String loginKayitOlunYz = 'Üye değil misiniz? Kaydolmak için tıklayın';
  final String takvimAppBarYz = 'Takvim';
  final String loginKaydolYz = 'Kayıt Ol';
  final String kullaniciAdiYz = 'Kullanıcı Adı';
  final String loginUyari = 'Boş geçilemez';
  final String calendarEnterTime = 'Saat';
  final String calendarEventMessage = 'Hatırlatma mesajı';
  // numbers
  final double fontSizeTextField = 15;
  final double fontSizeLoginTitle = 20;

  // link
  final loginIcon = 'assets/icons/calendar_icon.png';

  // calendarForm degiskenleri
  final currentUser = FirebaseAuth.instance.currentUser;
  late Map<DateTime, List<Event>> selectedEvents = {};
  final MaskTextInputFormatter timeMaskFormatter =
      MaskTextInputFormatter(mask: '##:##', filter: {
    "#": RegExp(r'[0-9]'),
  });
  final formKey = GlobalKey<FormState>();
  late DateTime selectedDay = DateTime.now();
  late DateTime focusedDay = DateTime.now();

  late CalendarFormat calendarFormat = CalendarFormat.month;

  var hatirlatmaNotu = '';
  var time = '';
}
