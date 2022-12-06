import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takvim_projesi/core/base/state/base_state.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:takvim_projesi/view/home/takvim/event.dart';
import 'package:takvim_projesi/view/home/history/history_screen.dart';
import '../../../core/constants/calendarConstants.dart';

class Calendar extends StatefulWidget {
  final List eventDocs;

  const Calendar({
    Key? key,
    required this.eventDocs,
  }) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends BaseState<Calendar> {
  CollectionReference events = FirebaseFirestore.instance.collection('Events');
  final TextEditingController eventController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  void setEvents(var eventDocs) {
    int length = eventDocs.length;
    for (int i = 0; i < length; i++) {
      setState(() {
        String year =
            (eventDocs[i]['event date'] as Timestamp).toDate().year.toString();
        String month =
            (eventDocs[i]['event date'] as Timestamp).toDate().month.toString();
        String day =
            (eventDocs[i]['event date'] as Timestamp).toDate().day.toString();
        int monthLength = month.length;
        if (monthLength == 1) {
          month = "0" + month;
        }
        int dayLength = day.length;

        if (dayLength == 1) {
          day = "0" + day;
        }
        String date = year + "-" + month + "-" + day + " 00:00:00.000Z";
        DateTime tarihSaat = DateTime.parse(date);
        onDaySelectedBuilder(tarihSaat, tarihSaat);
        _getEventsForDay(tarihSaat);
        if (CalendarConstants.instance.selectedEvents[tarihSaat] != null) {
          CalendarConstants.instance.selectedEvents[tarihSaat]!
              .add(Event(eventDocs[i]['mesaj'], eventDocs[i]['saat']));
        } else {
          CalendarConstants.instance.selectedEvents[tarihSaat] = [
            Event(eventDocs[i]['mesaj'], eventDocs[i]['saat'])
          ];
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    CalendarConstants.instance.selectedDay =
        CalendarConstants.instance.focusedDay;
    setEvents(widget.eventDocs);

    // final fbm = FirebaseMessaging.instance;
    // fbm.requestPermission();
    //
    // // // foreground message
    // FirebaseMessaging.onMessage.listen((event) {
    //
    //   (Map<String, dynamic> msg) async => print(msg);
    // });
    // //
    // // //background messafe
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   (Map<String, dynamic> msg) async => print(msg);
    // });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    eventController.dispose();
    timeController.dispose();
    CalendarConstants.instance.selectedEvents = {};
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime date) {
    return CalendarConstants.instance.selectedEvents[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar(),
        bottomNavigationBar: bottomAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TableCalendar(
                firstDay: kFirstDay,
                focusedDay: CalendarConstants.instance.focusedDay,
                lastDay: kLastDay,
                calendarFormat: CalendarConstants.instance.calendarFormat,
                selectedDayPredicate: selectedDayPrecidateBuilder,
                onDaySelected: onDaySelectedBuilder,
                onFormatChanged: onFormatChangedBuilder,
                eventLoader: _getEventsForDay,
                onPageChanged: onPageChangeBuilder,
                startingDayOfWeek: StartingDayOfWeek.monday,
              ),
              const SizedBox(height: 8.0),
              ...olaylariEkrandaGoster(),
            ],
          ),
        ),
      ),
    );
  }

  BottomAppBar bottomAppBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: [
            IconButton(
              tooltip: 'History',
              icon: const Icon(Icons.history),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const HistoryScreen();
                }));
              },
            ),
            const Spacer(),
            IconButton(
              tooltip: 'Add',
              icon: const Icon(Icons.add),
              onPressed: () => _showAddDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  void onPageChangeBuilder(focusedDay) {
    CalendarConstants.instance.focusedDay = focusedDay;
  }

  void onFormatChangedBuilder(format) {
    if (CalendarConstants.instance.calendarFormat != format) {
      setState(() {
        CalendarConstants.instance.calendarFormat = format;
      });
    }
  }

  void onDaySelectedBuilder(selectedDay, focusedDay) {
    if (!isSameDay(CalendarConstants.instance.selectedDay, selectedDay)) {
      setState(() {
        CalendarConstants.instance.selectedDay = selectedDay;
        CalendarConstants.instance.focusedDay = focusedDay;
      });
    }
  }

  bool selectedDayPrecidateBuilder(day) {
    return isSameDay(CalendarConstants.instance.selectedDay, day);
  }

  Iterable<Widget> olaylariEkrandaGoster() {
    return _getEventsForDay(CalendarConstants.instance.selectedDay).map(
      (Event event) => Container(
        height: dynamicHeight(0.08),
        child: ListTile(
          title: Text(event.title.toString()),
          subtitle: Text(event.time),
        ),
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(CalendarConstants.instance.takvimAppBarYz),
      actions: [
        IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }

  Future<dynamic> _showAddDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Event"),
        content: Form(
          key: CalendarConstants.instance.formKey,
          child: Column(
            children: [
              eventHatilaticiMesajTextField(),
              eventTimeTextField(),
            ],
          ),
        ),
        actions: [eventTamamButton(context), eventIptalButton(context)],
      ),
    );
  }

  TextFormField eventHatilaticiMesajTextField() {
    return TextFormField(
      controller: eventController,
      key: ValueKey(CalendarConstants.instance.calendarEventMessage),
      decoration: const InputDecoration(hintText: 'Hatırlatıcı mesaj'),
      onSaved: (String? value) =>
          CalendarConstants.instance.hatirlatmaNotu = value!,
    );
  }

  TextFormField eventTimeTextField() {
    return TextFormField(
      controller: timeController,
      key: ValueKey(CalendarConstants.instance.calendarEnterTime),
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      decoration: const InputDecoration(hintText: '00:00'),
      inputFormatters: <TextInputFormatter>[
        CalendarConstants.instance.timeMaskFormatter
      ],
      onSaved: (String? value) => CalendarConstants.instance.time = value!,
    );
  }

  TextButton eventIptalButton(BuildContext context) {
    return TextButton(
        child: const Text("İptal"),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  TextButton eventTamamButton(BuildContext context) {
    return TextButton(
      child: const Text(
        "Tamam",
      ),
      onPressed: () async {
        if (eventController.text.isEmpty) {
          Navigator.pop(context);
          return;
        } else {
          _saveFirebase(eventController.text, timeController.text,
              CalendarConstants.instance.selectedDay);
          setState(() {
            if (CalendarConstants.instance
                    .selectedEvents[CalendarConstants.instance.selectedDay] !=
                null) {
              CalendarConstants.instance
                  .selectedEvents[CalendarConstants.instance.selectedDay]!
                  .add(
                Event(eventController.text, timeController.text),
              );
            } else {
              CalendarConstants.instance
                  .selectedEvents[CalendarConstants.instance.selectedDay] = [
                Event(eventController.text, timeController.text)
              ];
            }
            eventController.clear();
            timeController.clear();
            Navigator.pop(context);
            setState(() {});
            return;
          });
        }
      },
    );
  }

  Future<void> _saveFirebase(
      String mesaj, String saat, DateTime eventDate) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('Events').add({
      'createdAt': Timestamp.now(),
      'kullanıcı ID': currentUser!.uid.toString(),
      'kullanıcı mail': currentUser.email,
      'mesaj': mesaj,
      'saat': saat,
      'event date': eventDate
    });
  }
}
