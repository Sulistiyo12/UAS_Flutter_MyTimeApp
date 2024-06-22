// alarm_models.dart

class Alarm {
  int id; // Tambahkan properti id untuk mengidentifikasi setiap alarm secara unik
  int hour;
  int minute;
  bool isRepeat;
  String repeat;
  String sound;
  bool isVibration;
  String label;

  Alarm({
    required this.id,
    required this.hour,
    required this.minute,
    required this.isRepeat,
    required this.repeat,
    required this.sound,
    required this.isVibration,
    required this.label,
  });

  Map<String, dynamic> toJson() => {
        'id': id, // Sertakan id dalam data JSON
        'hour': hour,
        'minute': minute,
        'isRepeat': isRepeat,
        'repeat': repeat,
        'sound': sound,
        'isVibration': isVibration,
        'label': label,
      };

  static Alarm fromJson(Map<String, dynamic> json) => Alarm(
        id: json['id'],
        hour: json['hour'],
        minute: json['minute'],
        isRepeat: json['isRepeat'],
        repeat: json['repeat'],
        sound: json['sound'],
        isVibration: json['isVibration'],
        label: json['label'],
      );
}
