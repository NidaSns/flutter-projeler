import 'package:flutter/material.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class Event {
  final String title;
  final String time;
  final Color backgroundColor;

  Event(this.title, this.time, {this.backgroundColor = Colors.lightBlue});

  @override
  String toString() => title + " " + time;
}
