import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(CubeTimerApp());
}

class CubeTimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cube Timer',
      home: MainPage(title: 'Cube Timer'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Timer? _timer;
  int _timeElapsed = 0;
  bool _timerStarted = false;
  bool _isFirstPress = true;

  void _tapDown() {
    if (_isFirstPress) {
      setState(() {
        _timeElapsed = 0;
      });
    } else {
      _stopTimer();
    }
  }

  void _tapUp() {
    if (_isFirstPress) {
      setState(() {
        _startTimer();
        _isFirstPress = false;
      });
    } else {
      setState(() {
        _isFirstPress = true;
      });
    }
  }

  void _startTimer() {
    const oneMillisecond = const Duration(milliseconds: 1);
    setState(() {
      _timeElapsed = 0;
      _timerStarted = true;
    });
    _timer = new Timer.periodic(
      oneMillisecond,
      (Timer timer) {
        if (_timerStarted) {
          setState(() {
            _timeElapsed++;
          });
        }
      },
    );
  }

  void _stopTimer() {
    setState(() {
      _timerStarted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      // HitTestBehavior doesn't seem to be a right thing to use for real code.
      // We need to investigate.
      behavior: HitTestBehavior.opaque,
      onTapUp: (TapUpDetails details) {
        _tapUp();
      },
      onTapDown: (TapDownDetails details) {
        _tapDown();
      },
      child: Center(
        child: Text(
          (_timeElapsed / 100.0).toStringAsFixed(2),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
