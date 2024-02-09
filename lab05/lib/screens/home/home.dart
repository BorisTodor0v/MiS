import 'package:calendar_view/calendar_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab03/models/exam.dart';
import 'package:lab03/screens/home/calendar.dart';
import 'package:lab03/screens/exam/exam_dialog.dart';
import 'package:lab03/services/auth.dart';
import 'package:lab03/services/database.dart';
import 'package:provider/provider.dart';
import 'package:lab03/screens/exam/all_exams.dart';
import 'package:lab03/services/location.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService = AuthService();
  bool showExamsGrid = true;

  void toggleView() {
    setState(() => showExamsGrid = !showExamsGrid);
  }

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
            // remove comment below to test notification with google maps route
            //IconButton(onPressed: NotificationService.showSimpleNotification, icon: Icon(Icons.notification_add_outlined)),
            IconButton(
              onPressed: LocationService().openGoogleMaps,
              icon: Icon(
                Icons.map_outlined,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  toggleView();
                });
              },
              icon: Icon(
                showExamsGrid ? Icons.calendar_month : Icons.grid_view,
                color: Theme.of(context).primaryColor,
              ),
              //label: showExamsGrid ? const Text("Calendar view") : const Text("Grid view"),
            ),
            IconButton(
              onPressed: (){
                showDialog(context: context, builder: (context) => const ExamDialog());
              },
              icon: Icon(Icons.add_box, color: Theme.of(context).primaryColor,),
            ),
            TextButton.icon(
              icon: const Icon(Icons.person),
              onPressed: () async {
                CalendarControllerProvider.of(context).controller.events.forEach((event) {
                  CalendarControllerProvider.of(context).controller.remove(event);
                });
                await _authService.signOut();
              },
              label: const Text("Sign out"),
            )
          ],
        ),
        body: showExamsGrid ? ShowExams(toggleView: toggleView) : Calendar(toggleView: toggleView),
      ),
    );
  }
}
