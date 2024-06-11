import 'dart:io';
import 'package:flutter/material.dart';
import 'package:swipe_speak/utils/tts.dart';
import 'package:swipe_speak/widgets/image_picker.dart';
import 'package:swipe_speak/widgets/swipe_button_widget.dart';

class SwipeSpeakScreen extends StatefulWidget {
  final String parsedText;

  SwipeSpeakScreen({super.key, required this.parsedText});

  @override
  _SwipeSpeakScreenState createState() => _SwipeSpeakScreenState();
}

class _SwipeSpeakScreenState extends State<SwipeSpeakScreen> {
  final TextToSpeech tts = TextToSpeech();
  bool isSpeaking = false;
  File? _backgroundImage;

  void onSwipeRight() {
    setState(() {
      isSpeaking = true;
    });
    tts.speak(widget.parsedText).then((_) {
      setState(() {
        isSpeaking = false;
      });
    });
  }

  void onSwipeLeft() {
    setState(() {
      isSpeaking = false;
    });
    tts.stop();
  }

  void setBackground(File image) {
    setState(() {
      _backgroundImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speak🔊'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  if (_backgroundImage != null)
                    Positioned.fill(
                      child: Image.file(
                        _backgroundImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  SingleChildScrollView(
                    child: Text(
                      widget.parsedText,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            BackgroundImagePicker(
              onImageSelected: setBackground,
            ),
            SizedBox(height: 20),
            SwipeButtonWidget(
              onSwipeRight: onSwipeRight,
              onSwipeLeft: onSwipeLeft,
            ),
            if (isSpeaking) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
