// theme_notifier_models.dart

import 'package:flutter/material.dart';

enum ClockType { Analog, Digital }

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  double _alarmVolume = 0.5;
  double _timerVolume = 0.5;
  ClockType _clockType = ClockType.Digital;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  double get alarmVolume => _alarmVolume;
  double get timerVolume => _timerVolume;
  ClockType get clockType => _clockType;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setAlarmVolume(double volume) {
    _alarmVolume = volume;
    notifyListeners();
  }

  void setTimerVolume(double volume) {
    _timerVolume = volume;
    notifyListeners();
  }

  void setClockType(ClockType clockType) {
    _clockType = clockType;
    notifyListeners();
  }
}
