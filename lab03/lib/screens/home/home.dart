import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab03/models/exam.dart';
import 'package:lab03/screens/exam/exam_dialog.dart';
import 'package:lab03/services/auth.dart';
import 'package:lab03/services/database.dart';
import 'package:provider/provider.dart';
import 'package:lab03/screens/exam/all_exams.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();

  Home({super.key});

  Future<String> getCurrentUserId() async {
    User user = await _authService.getCurrentUser();
    return user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Exam>>.value(
      initialData: const [],
      value: DatabaseService(uid: getCurrentUserId().toString()).exams,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Exams"),
          backgroundColor: Colors.blue.shade50,
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              onPressed: (){
                showDialog(context: context, builder: (context) => const ExamDialog());
              },
              icon: const Icon(Icons.add_box),
              label: const Text("Add a new exam"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.person),
              onPressed: () async {
                await _authService.signOut();
              },
              label: const Text("Sign out"),
            )
          ],
        ),
        body: const ShowExams(),
      ),
    );
  }
}
