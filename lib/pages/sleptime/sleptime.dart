import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SleepTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: Theme.of(context).brightness, // Use current brightness
        // Customize other Cupertino theme properties if needed
      ),
      child: Scaffold(
        appBar: AppBar(),
        body: ClockApp(),
      ),
    );
  }
}

class ClockApp extends StatefulWidget {
  @override
  _ClockAppState createState() => _ClockAppState();
}

class _ClockAppState extends State<ClockApp> {
  late DateTime _currentTime;
  late TimeOfDay _sleepTime;
  late TimeOfDay _wakeUpTime;
  late Timer _timer;
  bool _isSleepMessageShown = false;
  bool _isWakeUpMessageShown = false;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _sleepTime = TimeOfDay(hour: 22, minute: 0); // Default sleep time (22:00)
    _wakeUpTime = TimeOfDay(hour: 7, minute: 0); // Default wake-up time (07:00)
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
        _checkSleepStatus();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  bool _isSleepTimePassed(TimeOfDay time) {
    final now = TimeOfDay.fromDateTime(_currentTime);
    return (now.hour > time.hour ||
        (now.hour == time.hour && now.minute >= time.minute));
  }

  void _showDialogMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _checkSleepStatus() {
    if (!_isSleepMessageShown && _isSleepTimePassed(_sleepTime)) {
      final now = TimeOfDay.fromDateTime(_currentTime);
      String sleepMessage =
          "Selamat Tidur pada ${now.hour}:${now.minute.toString().padLeft(2, '0')}!";
      _showDialogMessage(sleepMessage);
      _isSleepMessageShown = true;
    }
    if (!_isWakeUpMessageShown &&
        _currentTime.hour == _wakeUpTime.hour &&
        _currentTime.minute == _wakeUpTime.minute) {
      _showDialogMessage("Ayo Bangun!");
      _isWakeUpMessageShown = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(10.0), // Tambah borderRadius
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[800] // Warna latar belakang gelap
                      : Colors.grey[200], // Warna latar belakang terang
                ),
                //TAMBAHKAN TULISAN JADWAL TIDUR DIDALAM BORDER SEBELAH POJOKO KANAN (LOGO ALARAM "Jadwal Tidur")
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _selectTime(context, true); // Set sleep time
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Waktu Tidur',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '${_sleepTime.hour}:${_sleepTime.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(fontSize: 48.0),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _selectTime(context, false); // Set wake-up time
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Waktu Bangun',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '${_wakeUpTime.hour}:${_wakeUpTime.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(fontSize: 48.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, bool isSleepTime) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: isSleepTime ? _sleepTime : _wakeUpTime,
    );
    if (selectedTime != null) {
      setState(() {
        if (isSleepTime) {
          _sleepTime = selectedTime;
          _isSleepMessageShown = false; // Reset sleep message shown state
          _checkSleepStatus(); // Check if it's time to sleep immediately
        } else {
          _wakeUpTime = selectedTime;
          _isWakeUpMessageShown = false; // Reset wake-up message shown state
        }
      });
    }
  }
}
