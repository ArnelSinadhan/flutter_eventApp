import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
part "event.g.dart";

@HiveType(typeId: 0)
class Event {
  @HiveField(0)
  final String eventTitle;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final DateTime startDate;

  @HiveField(3)
  final DateTime endDate;

  Event(
      {required this.eventTitle,
      required this.description,
      required this.startDate,
      required this.endDate});
}
