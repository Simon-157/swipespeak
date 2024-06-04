import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class FilePickerWidget extends StatelessWidget {
  final Function(File) onFilePicked;

  const FilePickerWidget({super.key, required this.onFilePicked});

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      File file = File(result.files.single.path!);
      onFilePicked(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: pickFile,
      child: Text('Pick PDF File'),
    );
  }
}
