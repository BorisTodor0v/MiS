import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab03/services/auth.dart';
import 'package:lab03/services/database.dart';
import 'package:lab03/shared/constants.dart';
import 'package:intl/intl.dart';

class ExamDialog extends StatefulWidget {
  const ExamDialog({super.key});

  @override
  State<ExamDialog> createState() => _ExamDialogState();
}

class _ExamDialogState extends State<ExamDialog> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String course = '';
  DateTime timestamp = DateTime.now();

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if(date == null) return;
    TimeOfDay? time = await pickTime();
    if(time == null) return;
    final dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(()=>timestamp = dateTime);
    return dateTime;
  }

  Future<DateTime?> pickDate() async {
    final datePicked = await showDatePicker(
      context: context,
      initialDate: timestamp,
      firstDate: DateTime(2022),
      lastDate: DateTime(2078),
    );
    return datePicked;
  }

  Future<TimeOfDay?>? pickTime() async {
    final timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: timestamp.hour, minute: timestamp.minute),
    );
    return timePicked;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter exam information'),
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Course name"),
                onChanged: (val) {
                  setState(() {
                    course = val;
                  });
                },
                validator: (val) {
                  if(val != null && val.isEmpty){
                    return "Course name cannot be blank";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 20,),
              const Text("Select the time for the exam"),
              TextButton.icon(
                onPressed: pickDateTime,
                icon: const Icon(Icons.edit_calendar),
                label: Text(
                  DateFormat('dd/MM/yyyy HH:mm').format(timestamp)
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      User user = await _authService.getCurrentUser();
                      await DatabaseService(uid: user.uid).addExam(course, timestamp);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Add exam"))
            ],
          ),
        ),
      )
    );
  }
}
