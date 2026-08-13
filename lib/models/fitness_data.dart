

enum DeviceStatus { connected, disconnected, connecting }

class FitnessDevice {
  final String id;
  final String name;
  final String category;
  final DeviceStatus status;
  final int level;
  final int batteryLevel;
  final String firmwareVersion;
  final String lastSynced;

  FitnessDevice({
    required this.id,
    required this.name,
    required this.category,
    required this.status,
    required this.level,
    required this.batteryLevel,
    required this.firmwareVersion,
    required this.lastSynced,
  });
}

class WorkoutSession {
  bool isWorkingOut;
  bool isPaused;
  int durationSeconds;
  int calories;
  int heartRate;
  int resistanceLevel;

  WorkoutSession({
    this.isWorkingOut = false,
    this.isPaused = false,
    this.durationSeconds = 1478, // 24:38 default
    this.calories = 184,
    this.heartRate = 72,
    this.resistanceLevel = 12,
  });

  String get formattedDuration {
    final minutes = (durationSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (durationSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
