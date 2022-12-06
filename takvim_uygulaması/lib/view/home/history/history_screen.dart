import 'package:flutter/material.dart';
import 'package:takvim_projesi/view/home/history/history_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildiriler'),
      ),
      body: Column(
        children: const [
          Expanded(
            child: HistoryService(),
          )
        ],
      ),
    );
  }
}
