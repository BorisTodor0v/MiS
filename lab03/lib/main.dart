import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab03/screens/wrapper.dart';
import 'package:lab03/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
// 191096 - Тодоров Борис
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: "AIzaSyCGPtQifHwV_tVPJ-6DUT7CcJCRe3QfHlk",
        appId: "1:802653666966:web:8993497ffc1c6f09100cb7",
        messagingSenderId: "802653666966",
        projectId: "mis-lab-d85ac"
      )
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
