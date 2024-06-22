import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DigitalClock extends StatefulWidget {
  final DateTime dateTime;

  DigitalClock({required this.dateTime});

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Set locale to Indonesian
    Intl.defaultLocale = 'id';
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _getFormattedTime() {
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    return DateFormat('EEEE, d MMMM yyyy', 'id').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start, // Align widgets to the top
      crossAxisAlignment:
          CrossAxisAlignment.center, // Center widgets horizontally
      children: [
        SizedBox(height: 50), // Optional: Space from the top of the screen
        Text(
          _getFormattedTime(),
          style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10), // Space between time and date
        Text(
          _getFormattedDate(),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
