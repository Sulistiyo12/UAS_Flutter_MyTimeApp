import 'package:flutter/material.dart';
import 'dart:async';

class CountdownPopup extends StatefulWidget {
  final String hours;
  final String minutes;
  final String seconds;
  final VoidCallback onClose;

  CountdownPopup({
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.onClose,
  });

  @override
  _CountdownPopupState createState() => _CountdownPopupState();
}

class _CountdownPopupState extends State<CountdownPopup> {
  late int _remainingTime;
  Timer? _timer;
  bool _isRunning = true;

  @override
  void initState() {
    super.initState();
    _remainingTime = (int.parse(widget.hours) * 3600) +
        (int.parse(widget.minutes) * 60) +
        int.parse(widget.seconds);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        timer.cancel();
      }
    });
    setState(() {
      _isRunning = true;
    });
  }

  void _pauseTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      setState(() {
        _isRunning = false;
      });
    } else {
      _startTimer();
    }
  }

  void _addOneMinute() {
    setState(() {
      _remainingTime += 60;
    });
  }

  void _resetTimer() {
    setState(() {
      _remainingTime = (int.parse(widget.hours) * 3600) +
          (int.parse(widget.minutes) * 60) +
          int.parse(widget.seconds);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(16.0),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.9, // 90% dari lebar layar
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Timer',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  ' ${widget.hours}h ${widget.minutes}m ${widget.seconds}s',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 300, // Tinggi lingkaran hitungan mundur
                  width: 300, // Lebar lingkaran hitungan mundur
                  child: CircularProgressIndicator(
                    value: _remainingTime /
                        ((int.parse(widget.hours) * 3600) +
                            (int.parse(widget.minutes) * 60) +
                            int.parse(widget.seconds)),
                    strokeWidth: 10, // Lebar garis lingkaran
                  ),
                ),
                Positioned(
                  bottom: 40,
                  child: IconButton(
                    onPressed: _resetTimer,
                    icon: Icon(Icons.refresh),
                    iconSize: 40, // Menambah ukuran ikon
                  ),
                ),
                Text(
                  '$_remainingTime',
                  style: TextStyle(fontSize: 48),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _addOneMinute,
                  child: Text(
                    '+1m',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Warna background tombol
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: _pauseTimer,
                  icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                  label: Text(_isRunning ? 'Pause' : 'Resume'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(
                        255, 27, 162, 47), // Warna background tombol
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: widget.onClose,
          child: Text('Close'),
        ),
      ],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TimerPage(),
    );
  }
}

class TimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CountdownPopup(
                  hours: '1',
                  minutes: '0',
                  seconds: '0',
                  onClose: () {
                    Navigator.of(context).pop();
                  },
                );
              },
            );
          },
          child: Text('Show Popup'),
        ),
      ),
    );
  }
}
