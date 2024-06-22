import 'package:flutter/material.dart';
import 'package:mytime_app/pages/alarm/add_alarm.dart';
import 'package:mytime_app/pages/alarm/edit_alarm.dart'; // Import halaman edit
import 'package:provider/provider.dart';
import 'package:mytime_app/providers/alarm_provider.dart';

class AlarmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<AlarmProvider>(
        builder: (context, alarmProvider, child) {
          if (alarmProvider.alarms.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.alarm_off,
                    size: 200,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Tidak Ada Alarm',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: alarmProvider.alarms.length,
              itemBuilder: (context, index) {
                final alarm = alarmProvider.alarms[index];
                return ListTile(
                  title: Text(
                    '${alarm.hour.toString().padLeft(2, '0')}:${alarm.minute.toString().padLeft(2, '0')} - ${alarm.label}',
                  ),
                  subtitle:
                      Text('Ulangi: ${alarm.repeat}, Nada: ${alarm.sound}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      alarmProvider.removeAlarm(alarm);
                    },
                  ),
                  onTap: () {
                    alarmProvider.startEditAlarm(alarm);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditAlarmPage()),
                    );
                  },
                  leading: IconButton(
                    icon:
                        Icon(alarm.isRepeat ? Icons.alarm_on : Icons.alarm_off),
                    onPressed: () {
                      alarmProvider.toggleAlarm(alarm);
                    },
                    color: alarm.isRepeat ? Colors.green : Colors.red,
                  ),
                );
              },
            );
          }
        },
      ),

      floatingActionButton: SizedBox(
        width: 70.0, // Atur lebar tombol
        height: 70.0, // Atur tinggi tombol
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddAlarmPage()),
            );
          },
          child: Icon(Icons.add, size: 36.0), // Atur ukuran ikon
          backgroundColor:
              Colors.blue, // Ganti warna background sesuai kebutuhan
          shape:
              CircleBorder(), // Menambahkan shape CircleBorder untuk membuat tombol menjadi bulat
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, // Letakkan tombol di tengah
    );
  }
}
