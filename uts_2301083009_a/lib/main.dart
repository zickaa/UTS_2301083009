import 'package:flutter/material.dart';
import 'screens/pdam_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JIK PDAM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PdamScreen(),
    );
  }
}
