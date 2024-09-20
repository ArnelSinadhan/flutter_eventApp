import 'package:flutter/material.dart';
import 'package:flutter_eventapp/models/event.dart';
import 'package:flutter_eventapp/screens/add_event.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    final eventBox = Hive.box<Event>('events');

    return ValueListenableBuilder(
      valueListenable: eventBox.listenable(),
      builder: (context, Box<Event> box, _) {
        if (box.isEmpty) {
          return const Center(
            child: Text('No events available'),
          );
        }

        return ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            final event = box.getAt(index) as Event;
            if (!eventBox.isOpen) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(event.eventTitle),
                      subtitle: Text(event.description),
                    ),
                    ListTile(
                      title: Text(DateFormat('yyyy-MM-dd HH:mm')
                          .format(event.startDate)),
                      subtitle: Text(
                          DateFormat('yyyy-MM-dd HH:mm').format(event.endDate)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddEvent(
                                            event: event,
                                          )));
                            },
                            child: const Text('Edit')),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                eventBox.deleteAt(index);
                              });
                            },
                            child: const Text('Delete'))
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
