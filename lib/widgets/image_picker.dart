import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BackgroundImagePicker extends StatefulWidget {
  final Function(File)? onImageSelected;

  const BackgroundImagePicker({Key? key, this.onImageSelected}) : super(key: key);

  @override
  _BackgroundImagePickerState createState() => _BackgroundImagePickerState();
}

class _BackgroundImagePickerState extends State<BackgroundImagePicker> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _imageFile;

  Future<void> _getImage() async {
    final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      widget.onImageSelected?.call(_imageFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _getImage,
          child: Text('Select Background Image'),
        ),
        // if (_imageFile != null)
        //   Container(
        //     margin: EdgeInsets.all(20),
        //     width: MediaQuery.of(context).size.width * 0.8,
        //     height: MediaQuery.of(context).size.height * 0.3,
        //     decoration: BoxDecoration(
        //       image: DecorationImage(
        //         image: FileImage(_imageFile!),
        //         fit: BoxFit.cover,
        //       ),
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //   ),
      ],
    );
  }
}
