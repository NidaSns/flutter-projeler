import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:takvim_projesi/view/authenticate/splash/splash_screen.dart';
import './calendarForm.dart';

class CalendarService extends StatelessWidget {
  const CalendarService({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Events')
            .orderBy(
              'event date',
              descending: false,
            )
            .snapshots(),
        builder: (ctx, eventSnapshot) {
          if (eventSnapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          final eventDocs = (eventSnapshot.data as QuerySnapshot).docs;

          return Calendar(
            eventDocs: eventDocs,
          );
        });
  }
}
