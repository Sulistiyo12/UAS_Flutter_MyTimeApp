// alarm_provider.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:mytime_app/models/alarm_models.dart';

class AlarmProvider with ChangeNotifier {
  List<Alarm> _alarms = [];
  Alarm? _editingAlarm;

  List<Alarm> get alarms => _alarms;
  Alarm? get editingAlarm => _editingAlarm;

  AlarmProvider() {
    _loadAlarms();
  }

  void addAlarm(Alarm alarm) {
    _alarms.add(alarm);
    _saveAlarms();
    notifyListeners();
  }

  void removeAlarm(Alarm alarm) {
    _alarms.remove(alarm);
    _saveAlarms();
    notifyListeners();
  }

  void updateAlarm(Alarm alarm) {
    final index = _alarms.indexWhere((a) => a.id == alarm.id);
    if (index != -1) {
      _alarms[index] = alarm;
      _saveAlarms();
      notifyListeners();
    }
  }

  void toggleAlarm(Alarm alarm) {
    final index = _alarms.indexWhere((a) => a.id == alarm.id);
    if (index != -1) {
      _alarms[index].isRepeat = !_alarms[index]
          .isRepeat; // Mengaktifkan atau menonaktifkan jadwal alarm
      _saveAlarms();
      notifyListeners();
    }
  }

  void startEditAlarm(Alarm alarm) {
    _editingAlarm = alarm;
    notifyListeners();
  }

  void endEditAlarm() {
    _editingAlarm = null;
    notifyListeners();
  }

  void _saveAlarms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> alarmStrings =
        _alarms.map((alarm) => jsonEncode(alarm.toJson())).toList();
    await prefs.setStringList('alarms', alarmStrings);
  }

  void _loadAlarms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? alarmStrings = prefs.getStringList('alarms');
    if (alarmStrings != null) {
      _alarms = alarmStrings
          .map((alarmString) => Alarm.fromJson(jsonDecode(alarmString)))
          .toList();
      notifyListeners();
    }
  }
}
