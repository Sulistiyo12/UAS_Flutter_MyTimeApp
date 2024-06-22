import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:mytime_app/providers/alarm_provider.dart';
import 'package:mytime_app/models/alarm_models.dart'; // Import model Alarm

class AddAlarmPage extends StatefulWidget {
  const AddAlarmPage({Key? key}) : super(key: key);

  @override
  State<AddAlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AddAlarmPage> {
  int _hour = 1;
  int _minute = 45;
  bool _isRepeat = false;
  String _repeat = 'S';
  String _sound = 'Sky';
  bool _isVibration = true;
  String _label = '';

  // Gunakan DateTime untuk menyimpan waktu real-time
  DateTime _currentTime = DateTime.now();
  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // Update _currentTime dengan waktu sekarang
        _currentTime = DateTime.now();
      });
    });
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: _currentTime.hour, minute: _currentTime.minute),
    ).then((value) {
      if (value != null) {
        setState(() {
          _hour = value.hour;
          _minute = value.minute;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambahkan alarm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gunakan _currentTime.hour dan _currentTime.minute untuk menampilkan waktu real-time
            Text(
              '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _showTimePicker,
                  child: const Text('Atur Waktu'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')} ${_isRepeat ? 'Ulangi Setiap $_repeat' : ''}',
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Text('Ulangi'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _repeat = 'M';
                      _isRepeat = true;
                    });
                  },
                  child: const Text('M'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _repeat = 'S';
                      _isRepeat = true;
                    });
                  },
                  child: const Text('S'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _repeat = 'S';
                      _isRepeat = true;
                    });
                  },
                  child: const Text('S'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _repeat = 'R';
                      _isRepeat = true;
                    });
                  },
                  child: const Text('R'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _repeat = 'K';
                      _isRepeat = true;
                    });
                  },
                  child: const Text('K'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Nada Dering'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _sound,
                    textAlign: TextAlign.start,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Show a list of sounds
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Getar'),
                Spacer(),
                Switch(
                  value: _isVibration,
                  onChanged: (value) {
                    setState(() {
                      _isVibration = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Label'),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Masukkan label (opsional)',
              ),
              onChanged: (value) {
                setState(() {
                  _label = value;
                });
              },
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Batal'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final alarmProvider =
                          Provider.of<AlarmProvider>(context, listen: false);
                      final newAlarm = Alarm(
                        id: DateTime.now().millisecondsSinceEpoch,
                        hour: _hour,
                        minute: _minute,
                        isRepeat: _isRepeat,
                        repeat: _repeat,
                        sound: _sound,
                        isVibration: _isVibration,
                        label: _label,
                      );
                      alarmProvider.addAlarm(newAlarm);
                      Navigator.pop(context);
                    },
                    child: const Text('Simpan'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
