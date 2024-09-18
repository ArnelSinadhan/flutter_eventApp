import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime? _startDate;
  DateTime? _endDate;

  // Function to pick a date and time
  Future<void> _pickDateTime(bool isStart) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        setState(() {
          if (isStart) {
            _startDate = fullDateTime;
          } else {
            _endDate = fullDateTime;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: const Text('Add Event'),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Event Title',
                      filled: true,
                      fillColor: (Color(0xFFFFFFFF)),
                      border: OutlineInputBorder()),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Description',
                      filled: true,
                      fillColor: (Color(0xFFFFFFFF)),
                      border: OutlineInputBorder()),
                ),
              ),
              Container(
                height: 56.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _startDate == null
                              ? 'Start Date'
                              : DateFormat('yyyy-MM-dd HH:mm')
                                  .format(_startDate!),
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _pickDateTime(true),
                      child: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
              Container(
                height: 56.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _endDate == null
                              ? 'End Date'
                              : DateFormat('yyyy-MM-dd HH:mm')
                                  .format(_endDate!),
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _pickDateTime(false),
                      child: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: Colors.green),
                child: const Text('Add Event'),
              )
            ],
          )),
    );
  }
}
