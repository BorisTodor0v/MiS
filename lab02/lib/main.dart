import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'clothing_provider.dart';
import 'clothing_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ClothingProvider(),
      child: MaterialApp(
        title: 'Лаб. 02 - Листа со облека',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ClothingListScreen(),
      ),
    );
  }
}
