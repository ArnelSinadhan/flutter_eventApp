import 'package:flutter/material.dart';
import 'package:flutter_eventapp/models/event.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  final Event? event; // Optional Event object for editing

  const AddEvent({super.key, this.event}); // event parameter added

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _eventTitle = '';
  String _description = '';
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      // Pre-fill the form if we are editing an event
      _eventTitle = widget.event!.eventTitle;
      _description = widget.event!.description;
      _startDate = widget.event!.startDate;
      _endDate = widget.event!.endDate;
    }
  }

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

  // Function to save or update the event
  void _saveEvent() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final event = Event(
        eventTitle: _eventTitle,
        description: _description,
        startDate: _startDate!,
        endDate: _endDate!,
      );

      final eventBox = Hive.box<Event>('events');

      if (widget.event != null) {
        // Update the existing event
        final index = eventBox.values.toList().indexOf(widget.event!);
        eventBox.putAt(index, event);
      } else {
        // Add a new event
        eventBox.add(event);
      }

      Navigator.pop(context); // Close the screen after saving
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: Text(widget.event == null ? 'Add Event' : 'Edit Event'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              child: TextFormField(
                initialValue:
                    _eventTitle, // Pre-fill with event title if editing
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter event title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _eventTitle = value!;
                },
                decoration: const InputDecoration(
                    labelText: 'Event Title',
                    filled: true,
                    fillColor: Color(0xFFFFFFFF),
                    border: OutlineInputBorder()),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              child: TextFormField(
                initialValue:
                    _description, // Pre-fill with description if editing
                onSaved: (value) {
                  _description = value!;
                },
                decoration: const InputDecoration(
                    labelText: 'Description',
                    filled: true,
                    fillColor: Color(0xFFFFFFFF),
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
                            : DateFormat('yyyy-MM-dd HH:mm').format(_endDate!),
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
              onPressed: _saveEvent,
              style: TextButton.styleFrom(foregroundColor: Colors.green),
              child: Text(widget.event == null ? 'Add Event' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
