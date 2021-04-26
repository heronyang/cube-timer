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
  bool _isFirstTap = true;
  Timer? _timer;
  Stopwatch _stopwatch = Stopwatch();

  void _tapDown() {
    if (_isFirstTap) {
      _stopwatch.reset();
    } else {
      _stopwatch.stop();
    }
  }

  void _tapUp() {
    if (_isFirstTap) {
      _stopwatch.start();
      setState(() {
        _isFirstTap = false;
      });
    } else {
      setState(() {
        _isFirstTap = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _timer = new Timer.periodic(new Duration(milliseconds: 10), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
          (_stopwatch.elapsedMilliseconds / 1000.0).toStringAsFixed(2),
        ),
      ),
    );
  }
}
