import 'package:calendar_view/calendar_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab03/screens/wrapper.dart';
import 'package:lab03/services/auth.dart';
import 'package:lab03/services/notification.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
// 191096 - Тодоров Борис
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await NotificationService.init();
  if(kIsWeb){
    await Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: "AIzaSyCGPtQifHwV_tVPJ-6DUT7CcJCRe3QfHlk",
        appId: "1:802653666966:web:8993497ffc1c6f09100cb7",
        messagingSenderId: "802653666966",
        projectId: "mis-lab-d85ac"
      )
    );
  } else { //Android
    await Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: 'AIzaSyBRbm_FM7ElabXbomhIALgkvTT3YwhBB9s',
      appId: '1:802653666966:android:1eb73a63f042a3d1100cb7',
      messagingSenderId: '802653666966',
      projectId: 'mis-lab-d85ac',)
    );
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
      child: CalendarControllerProvider(
          controller: EventController(),
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Wrapper(),
          ),
      )
    );
  }
}
