import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: ListView(
        children: [
          Card(
            child: Column(
              children: [
                const ListTile(
                  title: Text('Title'),
                  subtitle: Text('Desciption'),
                ),
                const ListTile(
                  title: Text('Start'),
                  subtitle: Text('End'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () {}, child: const Text('Edit')),
                    TextButton(onPressed: () {}, child: const Text('Delete'))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
