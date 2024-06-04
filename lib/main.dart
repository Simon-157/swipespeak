import 'package:flutter/material.dart';
import 'package:swipe_speak/screens/file_picker_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SwipeSpeak 🔊',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FilePickerScreen(),
    );
  }
}
