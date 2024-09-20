import 'package:flutter/material.dart';
import 'package:flutter_eventapp/models/event.dart';
import 'package:flutter_eventapp/screens/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // init hive
  await Hive.initFlutter();

  // Register adapter
  Hive.registerAdapter(EventAdapter());

  // Open box for event
  await Hive.openBox<Event>('events');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.amber[100]),
      ),
      home: const Homepage(),
    );
  }
}
