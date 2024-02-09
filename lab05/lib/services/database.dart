import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab03/models/exam.dart';

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String uid;
  DatabaseService({ required this.uid });

  // collection reference
  final CollectionReference examCollection = FirebaseFirestore.instance.collection('exams_lab03');

  Future addExam(String courseName, DateTime timestamp) async {
    return await examCollection.doc().set({
      'user': uid.toString(),
      'course': courseName,
      'timestamp': timestamp,
    });
  }

  // get exams stream
  Stream<List<Exam>> get exams async* {
    final user = await _auth.authStateChanges().first;
    if (user != null) {
      yield* examCollection.where('user', isEqualTo: user.uid).snapshots().map(_examListFromSnapshot);
    } else {
      yield [];
    }
  }


  // exam list from snapshot
  List<Exam> _examListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      Exam exam = Exam(
        course: doc.get('course'),
        timestamp: (doc.get('timestamp') as Timestamp).toDate()
      );
      return exam;
    }).toList();
  }

}