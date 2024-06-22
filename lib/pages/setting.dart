import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mytime_app/models/theme_notifier_models.dart';

class SettingsPage extends StatelessWidget {
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tentang Aplikasi'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Aplikasi ini dibuat untuk memudahkan pengguna dalam mengatur waktu. Pengembangan aplikasi ini guna Project UAS mata kuliah Mobile Programming Lanjut, STMIK Widya Utama Purwokerto.'),
              SizedBox(height: 10),
              Text('Pengembang:'),
              Text('Abdul Fais STI202102147'),
              Text('Muarif Subekhi STI202102135'),
              Text('Sulistiyo STI202102161')
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setelan'),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'TAMPILAN',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text('Tema Gelap'),
                trailing: Switch(
                  value: Provider.of<ThemeNotifier>(context).isDarkMode,
                  onChanged: (value) {
                    Provider.of<ThemeNotifier>(context, listen: false)
                        .toggleTheme();
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'JAM',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text('Gaya Jam'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: Text('Pilih Gaya Jam'),
                        children: [
                          SimpleDialogOption(
                            onPressed: () {
                              Provider.of<ThemeNotifier>(context, listen: false)
                                  .setClockType(
                                      ClockType.Analog); // Set jam analog
                              Navigator.pop(context);
                            },
                            child: Text('Analog'),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Provider.of<ThemeNotifier>(context, listen: false)
                                  .setClockType(
                                      ClockType.Digital); // Set jam digital
                              Navigator.pop(context);
                            },
                            child: Text('Digital'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'ALARM',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text('Volume Alarm'),
                onTap: () {
                  // Tambahkan logika untuk mengatur volume alarm
                },
              ),
              Slider(
                value: Provider.of<ThemeNotifier>(context).alarmVolume,
                onChanged: (double value) {
                  Provider.of<ThemeNotifier>(context, listen: false)
                      .setAlarmVolume(value);
                },
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'TIMER',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text('Volume Timer'),
                onTap: () {
                  // Tambahkan logika untuk mengatur volume timer
                },
              ),
              Slider(
                value: Provider.of<ThemeNotifier>(context).timerVolume,
                onChanged: (double value) {
                  Provider.of<ThemeNotifier>(context, listen: false)
                      .setTimerVolume(value);
                },
              ),
              Divider(),
              ListTile(
                title: Text('About'),
                onTap: () {
                  _showAboutDialog(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
