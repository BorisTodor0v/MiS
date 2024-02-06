import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab03/models/exam.dart';
import 'package:lab03/screens/exam/exam_item.dart';

class ShowExams extends StatefulWidget {
  const ShowExams({super.key});

  @override
  State<ShowExams> createState() => _ShowExamsState();
}

class _ShowExamsState extends State<ShowExams> {
  @override
  Widget build(BuildContext context) {
    final exams = Provider.of<List<Exam>>(context);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemCount: exams.length,
      itemBuilder: (context, index){
        return ExamItem(exam: exams[index]);
      },
    );
  }
}
