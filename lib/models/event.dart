import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Event {
  String title;
  String content;
  DateTime startDate;
  DateTime endDate;

  Event({
    required this.title,
    required this.content,
    required this.startDate,
    required this.endDate,
  });

  // Convert Event object to a map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }

  // Convert map to Event object
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      title: map['title'],
      content: map['content'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
    );
  }
}

class EventStorage {
  static const String _eventListKey = 'eventList';

  // Save the event list to local storage
  Future<void> saveEventList(List<Event> eventList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> eventListJson =
        eventList.map((event) => jsonEncode(event.toMap())).toList();
    await prefs.setStringList(_eventListKey, eventListJson);
  }

  // Retrieve the event list from local storage
  Future<List<Event>> getEventList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? eventListJson = prefs.getStringList(_eventListKey);

    if (eventListJson != null) {
      return eventListJson
          .map((eventJson) => Event.fromMap(jsonDecode(eventJson)))
          .toList();
    } else {
      return [];
    }
  }
}
