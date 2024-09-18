import 'package:hive/hive.dart';

@HiveType(typeId: 1)
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
