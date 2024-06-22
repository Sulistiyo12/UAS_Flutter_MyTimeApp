import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:mytime_app/providers/alarm_provider.dart';
import 'package:mytime_app/models/alarm_models.dart';

class EditAlarmPage extends StatefulWidget {
  const EditAlarmPage({Key? key}) : super(key: key);

  @override
  State<EditAlarmPage> createState() => _EditAlarmPageState();
}

class _EditAlarmPageState extends State<EditAlarmPage> {
  late int _hour;
  late int _minute;
  late bool _isRepeat;
  late String _repeat;
  late String _sound;
  late bool _isVibration;
  late String _label;

  // Gunakan DateTime untuk menyimpan waktu real-time
  DateTime _currentTime = DateTime.now();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    final alarmProvider = Provider.of<AlarmProvider>(context, listen: false);
    final editingAlarm = alarmProvider.editingAlarm;
    if (editingAlarm != null) {
      _hour = editingAlarm.hour;
      _minute = editingAlarm.minute;
      _isRepeat = editingAlarm.isRepeat;
      _repeat = editingAlarm.repeat;
      _sound = editingAlarm.sound;
      _isVibration = editingAlarm.isVibration;
      _label = editingAlarm.label;
    }
  }

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
      initialTime: TimeOfDay(hour: _hour, minute: _minute),
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
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Alarm'),
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
                    '${_hour.toString().padLeft(2, '0')}:${_minute.toString().padLeft(2, '0')} ${_isRepeat ? 'Ulangi Setiap $_repeat' : ''}',
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Ulangi'),
            const SizedBox(height: 8),
            // Tambahkan kode untuk memilih ulang alarm
            // sesuai dengan nilai _repeat yang sudah ada
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Tambahkan tombol untuk memilih ulang alarm
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
                      final alarmProvider =
                          Provider.of<AlarmProvider>(context, listen: false);
                      final editingAlarm = alarmProvider.editingAlarm;
                      if (editingAlarm != null) {
                        alarmProvider.removeAlarm(editingAlarm);
                        Navigator.pop(context);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors
                          .red), // Ubah warna latar belakang tombol menjadi merah
                    ),
                    child: const Text('Hapus'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final alarmProvider =
                          Provider.of<AlarmProvider>(context, listen: false);
                      final updatedAlarm = Alarm(
                        id: alarmProvider.editingAlarm!.id,
                        hour: _hour,
                        minute: _minute,
                        isRepeat: _isRepeat,
                        repeat: _repeat,
                        sound: _sound,
                        isVibration: _isVibration,
                        label: _label,
                      );
                      alarmProvider.updateAlarm(updatedAlarm);
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
