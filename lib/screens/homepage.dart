import 'package:flutter/material.dart';
import 'package:flutter_eventapp/models/event.dart';
import 'package:flutter_eventapp/screens/add_event.dart';
import 'package:flutter_eventapp/screens/event_list.dart';
import 'package:hive/hive.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final eventBox = Hive.box<Event>('events');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: const Text('Event App'),
      ),
      body: const EventList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddEvent();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
