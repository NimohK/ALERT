class Alert {
  final String type;
  final String description;
  final String location;
  final DateTime time;

  Alert({
    required this.type,
    required this.description,
    required this.location,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'description': description,
      'location': location,
      'time': time.toIso8601String(),
    };
  }

  factory Alert.fromMap(Map<String, dynamic> map) {
    return Alert(
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      time: DateTime.parse(map['time'] ?? DateTime.now().toIso8601String()),
    );
  }
} 