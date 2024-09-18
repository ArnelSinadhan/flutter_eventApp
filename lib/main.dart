import 'package:flutter/material.dart';
import 'package:flutter_eventapp/screens/homepage.dart';

void main() {
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
