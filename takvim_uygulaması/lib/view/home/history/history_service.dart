import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:takvim_projesi/view/home/history/history_form.dart';

class HistoryService extends StatelessWidget {
  const HistoryService({
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final eventDocs = (eventSnapshot.data as QuerySnapshot).docs;
          // void getallEvent(Map<DateTime, List<Event>> _selectedEvents) {
          //   for (var i; i < eventDocs.length; i++) {
          //     _selectedEvents[eventDocs[i]['event date']]!
          //         .addAll([Event(eventDocs[i]['mesaj'], eventDocs[i]['saat'])]);
          //   }
          // }

          return ListView.builder(
            itemCount: eventDocs.length,
            itemBuilder: (ctx, index) => HistoryForm(
              eventDocs[index]['event date'],
              eventDocs[index]['mesaj'],
              eventDocs[index]['saat'],
              eventDocs[index]['kullanıcı mail'],
              key: ValueKey(eventDocs[index].id),
            ),
          );
        });
  }
}
