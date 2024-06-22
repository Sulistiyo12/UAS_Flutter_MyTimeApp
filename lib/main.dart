//main.dart

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:mytime_app/models/theme_notifier_models.dart';
import 'package:mytime_app/providers/alarm_provider.dart';
import 'package:mytime_app/pages/sleptime/sleptime.dart';
import 'package:mytime_app/pages/setting.dart';
import 'package:mytime_app/pages/alarm/alarm.dart';
import 'package:mytime_app/pages/jam/jam.dart';
import 'package:mytime_app/pages/timer/timer.dart';
import 'package:mytime_app/pages/stopwatch.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(
            create: (_) => AlarmProvider()), // Register AlarmProvider
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            title: 'MyApp',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeNotifier.themeMode,
            debugShowCheckedModeBanner: false,
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = [
    AlarmPage(),
    JamPage(),
    TimerPage(), // Use TimerPage here
    StopwatchPage(),
    SleepTime(), // Add WaktuTidurPage
  ];

  final List<String> _titles = [
    'Alarm',
    'Jam',
    'Timer',
    'Stopwatch',
    'Waktu Tidur', // Add label for Waktu Tidur
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
        elevation: 0,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Alarm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            label: 'Jam',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hourglass_empty),
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Stopwatch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bedtime), // Use a bed icon for Sleep Timer
            label: 'Waktu Tidur',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: themeNotifier.isDarkMode
            ? Colors.white
            : Colors.black, // Dynamic selected item color
        unselectedItemColor: Colors.grey, // Warna item yang tidak dipilih
        backgroundColor: themeNotifier.isDarkMode
            ? Colors.black
            : Colors.white, // Dynamic background color
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
    );
  }
}
