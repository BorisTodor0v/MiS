import 'package:flutter/material.dart';
import 'package:lab03/models/exam.dart';
import 'package:intl/intl.dart';

class ExamItem extends StatelessWidget {

  final Exam exam;

  const ExamItem({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8),
      child: Card(
        color: Colors.blue.shade50,
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(
            exam.course,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
              DateFormat('dd/MM/yyyy HH:mm').format(exam.timestamp),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

