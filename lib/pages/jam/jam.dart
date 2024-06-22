import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mytime_app/pages/jam/search_jam.dart';
import 'package:provider/provider.dart';
import 'package:mytime_app/models/theme_notifier_models.dart';
import 'package:mytime_app/pages/jam/analog_jam.dart';
import 'package:mytime_app/pages/jam/digital_jam.dart';

class JamPage extends StatefulWidget {
  @override
  _JamPageState createState() => _JamPageState();
}

class _JamPageState extends State<JamPage> {
  late Timer _timer;
  late Stream<DateTime> _timeStream;
  List<String> timeZones = [];

  @override
  void initState() {
    super.initState();
    _timeStream =
        Stream<DateTime>.periodic(Duration(seconds: 1), (_) => DateTime.now());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: StreamBuilder<DateTime>(
          stream: _timeStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Consumer<ThemeNotifier>(
                builder: (context, jamProvider, child) {
                  return Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: jamProvider.clockType == ClockType.Analog
                            ? AnalogClock(dateTime: snapshot.data!)
                            : DigitalClock(dateTime: snapshot.data!),
                      ),
                      // Tambahkan elemen lain di bawah ini jika diperlukan
                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for (var timeZone in timeZones)
                              Text(
                                timeZone,
                                style: TextStyle(fontSize: 20),
                              ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),

      floatingActionButton: SizedBox(
        width: 70.0, // Atur lebar tombol
        height: 70.0, // Atur tinggi tombol
        child: FloatingActionButton(
          onPressed: () async {
            final selectedTimeZone = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchTime()),
            );
            if (selectedTimeZone != null) {
              setState(() {
                timeZones.add(selectedTimeZone);
              });
            }
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
