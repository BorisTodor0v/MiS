import 'package:flutter/material.dart';
import 'package:lab03/services/notification.dart';
import 'package:provider/provider.dart';
import 'package:lab03/models/exam.dart';
import 'package:lab03/screens/exam/exam_item.dart';

class ShowExams extends StatefulWidget {
  final Function toggleView;
  const ShowExams({super.key, required this.toggleView});

  @override
  State<ShowExams> createState() => _ShowExamsState();
}

class _ShowExamsState extends State<ShowExams> {

  // notifications only work when app is running. schedule them on each startup
  Future<void> scheduleNotifications(List<Exam> exams, BuildContext context) async {
    NotificationService.cancelScheduledNotifications(); // cancel pending notifications when logging out user
    for(Exam exam in exams){
      NotificationService.showScheduledNotificationDayBefore(exam.course, exam.timestamp);
      NotificationService.showScheduledNotificationHourBefore(exam.course, exam.timestamp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final exams = Provider.of<List<Exam>>(context);
    scheduleNotifications(exams, context);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: exams.length,
      itemBuilder: (context, index){
        return ExamItem(exam: exams[index]);
      },
    );
  }
}
