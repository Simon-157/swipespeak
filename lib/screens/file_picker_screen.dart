import 'package:flutter/material.dart';
import 'package:swipe_speak/screens/playgroud_screen.dart';
import 'package:swipe_speak/widgets/file_picker_widget.dart';
import 'package:swipe_speak/utils/pdf_parser.dart';
import 'dart:io';

class FilePickerScreen extends StatefulWidget {
  const FilePickerScreen({super.key});

  @override
  _FilePickerScreenState createState() => _FilePickerScreenState();
}

class _FilePickerScreenState extends State<FilePickerScreen> {
  void onFilePicked(File file) async {
    String parsedText = await parsePdf(file);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SwipeSpeakScreen(parsedText: parsedText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a file'),
      ),
      body: Center(
        child: FilePickerWidget(onFilePicked: onFilePicked),
      ),
    );
  }
}
