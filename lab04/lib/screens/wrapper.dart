import 'package:flutter/material.dart';
import 'package:lab03/models/user.dart';
import 'package:lab03/screens/authenticate/authenticate.dart';
import 'package:lab03/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if(user == null){
      return const Authenticate();
    } else {
      return const Home();
    }
  }
}
