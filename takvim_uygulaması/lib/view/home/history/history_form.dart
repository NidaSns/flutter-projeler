import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:takvim_projesi/core/constants/calendar_constants.dart';

class HistoryForm extends StatelessWidget {
  final Timestamp eventDate;
  final String mesaj;
  final String saat;
  final String kullaniciMail;

  const HistoryForm(this.eventDate, this.mesaj, this.saat, this.kullaniciMail,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          //clipBehavior: Clip.none,
          color: CalendarConstants.instance.appleBlossom,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Bildirim ve saati:" + mesaj + " " + saat,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                "Kullanıcı mail adresi: " + kullaniciMail,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                "Bildirim tarihi: " +
                    eventDate.toDate().year.toString() +
                    "/" +
                    eventDate.toDate().month.toString() +
                    "/" +
                    eventDate.toDate().day.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
