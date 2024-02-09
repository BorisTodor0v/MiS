import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:lab03/models/exam.dart';
import 'package:lab03/screens/exam/exam_details_calendar.dart';
import 'package:provider/provider.dart';

class Calendar extends StatelessWidget {
  final Function toggleView;
  const Calendar({super.key, required this.toggleView});

  Future<void> addEventsToCalendar(List<Exam> exams, BuildContext context) async {
    for(Exam exam in exams){
      final event = await CalendarEventData(title: exam.course, date: exam.timestamp);
      CalendarControllerProvider.of(context).controller.add(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    final exams = Provider.of<List<Exam>>(context);
    addEventsToCalendar(exams, context);


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
