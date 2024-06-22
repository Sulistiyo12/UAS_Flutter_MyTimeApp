import 'package:flutter/material.dart';
import 'timer_countdown.dart'; // Pastikan ini adalah file yang benar

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  String _hours = '00';
  String _minutes = '00';
  String _seconds = '00';
  bool _showPopup = false;

  void _onNumberPressed(String number) {
    setState(() {
      String currentTime = '$_hours$_minutes$_seconds';
      currentTime = currentTime.replaceFirst('00', '').padLeft(6, '0');
      currentTime = currentTime + number;
      currentTime = currentTime.substring(currentTime.length - 6);

      _hours = currentTime.substring(0, 2);
      _minutes = currentTime.substring(2, 4);
      _seconds = currentTime.substring(4, 6);
    });
  }

  void _onClearPressed() {
    setState(() {
      _hours = '00';
      _minutes = '00';
      _seconds = '00';
    });
  }

  void _onPlayPressed() {
    setState(() {
      _showPopup = true;
    });
  }

  void _closePopup() {
    setState(() {
      _showPopup = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$_hours j $_minutes m $_seconds d',
                style: TextStyle(fontSize: 60),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildNumberButton('1'),
                      _buildNumberButton('2'),
                      _buildNumberButton('3'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildNumberButton('4'),
                      _buildNumberButton('5'),
                      _buildNumberButton('6'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildNumberButton('7'),
                      _buildNumberButton('8'),
                      _buildNumberButton('9'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildNumberButton('00'),
                      _buildNumberButton('0'),
                      _buildClearButton(),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              if (_hours != '00' || _minutes != '00' || _seconds != '00')
                ElevatedButton(
                  onPressed: _onPlayPressed,
                  child: Icon(Icons.play_arrow, size: 60),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    backgroundColor: Colors.blue,
                    shape: CircleBorder(),
                  ),
                ),
            ],
          ),
          if (_showPopup)
            Stack(
              children: [
                ModalBarrier(
                    color: Colors.black.withOpacity(0.5), dismissible: false),
                CountdownPopup(
                  hours: _hours,
                  minutes: _minutes,
                  seconds: _seconds,
                  onClose: _closePopup,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return Container(
      width: 100, // Adjusted size for bigger buttons
      height: 100, // Adjusted size for bigger buttons
      margin: EdgeInsets.all(5), // Added margin for spacing
      child: ElevatedButton(
        onPressed: () => _onNumberPressed(number),
        child: Text(
          number,
          style: TextStyle(fontSize: 30),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(), // Circular shape
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return Container(
      width: 100, // Adjusted size for bigger buttons
      height: 100, // Adjusted size for bigger buttons
      margin: EdgeInsets.all(5), // Added margin for spacing
      child: ElevatedButton(
        onPressed: _onClearPressed,
        child: Icon(Icons.backspace),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(), // Circular shape
        ),
      ),
    );
  }
}
