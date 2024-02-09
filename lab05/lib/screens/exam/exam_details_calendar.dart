import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExamDetailsFromCalendar extends StatelessWidget {
  final CalendarEventData examEvent;
  const ExamDetailsFromCalendar({super.key, required this.examEvent});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(examEvent.title),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Text("Date: ${DateFormat('dd/MM/yyyy').format(examEvent.date)}"),
            const SizedBox(height: 20,),
            Text("Time: ${DateFormat('HH:mm').format(examEvent.date)}"),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: const Text("Close")
            )
          ],
        ),
      ),
    );
  }
}
