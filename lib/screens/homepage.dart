import 'package:flutter/material.dart';
import 'package:flutter_eventapp/screens/add_event.dart';
import 'package:flutter_eventapp/screens/event_list.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: const Text('Event App'),
      ),
      body: EventList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddEvent();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
