import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:lab03/models/exam.dart';
import 'package:lab03/screens/exam/exam_details_calendar.dart';
import 'package:provider/provider.dart';

class Calendar extends StatelessWidget {
  final Function toggleView;
  const Calendar({super.key, required this.toggleView});

  @override
  Widget build(BuildContext context) {
    final exams = Provider.of<List<Exam>>(context);
    for (Exam exam in exams) {
      CalendarControllerProvider.of(context).controller.add(
          CalendarEventData(title: exam.course, date: exam.timestamp)
      );
    }

    return Scaffold(
      body: MonthView(
        onEventTap: (event, date){
          showDialog(
            context: context,
            builder: (context) => ExamDetailsFromCalendar(examEvent: event,)
          );
        },
      ),
    );
  }
}
