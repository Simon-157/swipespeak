import 'package:flutter/material.dart';

class SwipeButtonWidget extends StatefulWidget {
  final VoidCallback onSwipeRight;
  final VoidCallback onSwipeLeft;

  const SwipeButtonWidget({
    super.key,
    required this.onSwipeRight,
    required this.onSwipeLeft,
  });

  @override
  _SwipeButtonWidgetState createState() => _SwipeButtonWidgetState();
}

class _SwipeButtonWidgetState extends State<SwipeButtonWidget> {
  double _leftButtonOffset = 0;
  double _rightButtonOffset = 0;
  final double _buttonWidth = 100;
  final double _buttonHeight = 100;
  final double _maxDragDistance = 150;

  void _onHorizontalDragUpdateLeft(DragUpdateDetails details) {
    setState(() {
      _leftButtonOffset += details.delta.dx;
      if (_leftButtonOffset < -_maxDragDistance) {
        _leftButtonOffset = -_maxDragDistance;
      } else if (_leftButtonOffset > 0) {
        _leftButtonOffset = 0;
      }
    });
  }

  void _onHorizontalDragEndLeft(DragEndDetails details) {
    if (_leftButtonOffset <= -_maxDragDistance * 0.5) {
      widget.onSwipeLeft();
    }
    setState(() {
      _leftButtonOffset = 0;
    });
  }

  void _onHorizontalDragUpdateRight(DragUpdateDetails details) {
    setState(() {
      _rightButtonOffset += details.delta.dx;
      if (_rightButtonOffset > _maxDragDistance) {
        _rightButtonOffset = _maxDragDistance;
      } else if (_rightButtonOffset < 0) {
        _rightButtonOffset = 0;
      }
    });
  }

  void _onHorizontalDragEndRight(DragEndDetails details) {
    if (_rightButtonOffset >= _maxDragDistance * 0.5) {
      widget.onSwipeRight();
    }
    setState(() {
      _rightButtonOffset = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Swipe 👉 Start, Swipe 👈 to Cancel',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(106, 19, 53, 46)),
        ),
        const SizedBox(height: 20),
        Container(
          height: _buttonHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: MediaQuery.of(context).size.width / 4 + _leftButtonOffset,
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragUpdateLeft,
                  onHorizontalDragEnd: _onHorizontalDragEndLeft,
                  child: Container(
                    width: _buttonWidth,
                    height: _buttonHeight,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.cancel, color: Colors.white, size: 50),
                  ),
                ),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width / 4 - _rightButtonOffset,
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragUpdateRight,
                  onHorizontalDragEnd: _onHorizontalDragEndRight,
                  child: Container(
                    width: _buttonWidth,
                    height: _buttonHeight,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow, color: Colors.white, size: 50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
