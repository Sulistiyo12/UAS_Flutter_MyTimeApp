import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Pastikan untuk menambahkan paket ini dalam pubspec.yaml

class AnalogClock extends StatefulWidget {
  final DateTime dateTime;

  AnalogClock({required this.dateTime});

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
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

  String _getFormattedDate() {
    final now = DateTime.now();
    return DateFormat('EEEE, d MMMM yyyy', 'id').format(now);
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width *
        0.5; // Mengecilkan ukuran jam analog
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 100), // Menambahkan jarak dari atas layar
        Container(
          width: size,
          height: size,
          child: CustomPaint(
            painter: ClockPainter(DateTime.now()),
          ),
        ),
        SizedBox(height: 5), // Space between clock and date
        Text(
          _getFormattedDate(),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
        ),
        SizedBox(height: 10), // Optional: Space from the bottom of the screen
      ],
    );
  }
}

class ClockPainter extends CustomPainter {
  final DateTime dateTime;

  ClockPainter(this.dateTime);

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = size.width / 2;

    Paint fillBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Paint outlineBrush = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    Paint centerBrush = Paint()..color = Colors.black;

    Paint secHandBrush = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Paint minHandBrush = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    Paint hourHandBrush = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    canvas.drawCircle(Offset(centerX, centerY), radius, fillBrush);
    canvas.drawCircle(Offset(centerX, centerY), radius, outlineBrush);
    canvas.drawCircle(Offset(centerX, centerY), 8, centerBrush);

    double secHandX =
        centerX + radius * 0.8 * cos(dateTime.second * 6 * pi / 180 - pi / 2);
    double secHandY =
        centerY + radius * 0.8 * sin(dateTime.second * 6 * pi / 180 - pi / 2);

    double minHandX =
        centerX + radius * 0.7 * cos(dateTime.minute * 6 * pi / 180 - pi / 2);
    double minHandY =
        centerY + radius * 0.7 * sin(dateTime.minute * 6 * pi / 180 - pi / 2);

    double hourHandX = centerX +
        radius *
            0.5 *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180 -
                pi / 2);
    double hourHandY = centerY +
        radius *
            0.5 *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180 -
                pi / 2);

    canvas.drawLine(
        Offset(centerX, centerY), Offset(secHandX, secHandY), secHandBrush);
    canvas.drawLine(
        Offset(centerX, centerY), Offset(minHandX, minHandY), minHandBrush);
    canvas.drawLine(
        Offset(centerX, centerY), Offset(hourHandX, hourHandY), hourHandBrush);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
