import 'package:cloud_firestore/cloud_firestore.dart';

/// Model class representing a community alert
class AlertModel {
  final String id;
  final String type;
  final String description;
  final String location;
  final DateTime timestamp;
  final String? recordingUrl; // For future audio recording feature

  AlertModel({
    required this.id,
    required this.type,
    required this.description,
    required this.location,
    required this.timestamp,
    this.recordingUrl,
  });

  /// Create AlertModel from Firestore document
  factory AlertModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return AlertModel(
      id: doc.id,
      type: data['type'] ?? '',
      description: data['description'] ?? '',
      location: data['location'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      recordingUrl: data['recordingUrl'],
    );
  }

  /// Convert AlertModel to Firestore document data
  Map<String, dynamic> toFirestore() {
    return {
      'type': type,
      'description': description,
      'location': location,
      'timestamp': Timestamp.fromDate(timestamp),
      'recordingUrl': recordingUrl,
    };
  }

  /// Create a copy of AlertModel with updated fields
  AlertModel copyWith({
    String? id,
    String? type,
    String? description,
    String? location,
    DateTime? timestamp,
    String? recordingUrl,
  }) {
    return AlertModel(
      id: id ?? this.id,
      type: type ?? this.type,
      description: description ?? this.description,
      location: location ?? this.location,
      timestamp: timestamp ?? this.timestamp,
      recordingUrl: recordingUrl ?? this.recordingUrl,
    );
  }

  @override
  String toString() {
    return 'AlertModel(id: $id, type: $type, description: $description, location: $location, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AlertModel &&
        other.id == id &&
        other.type == type &&
        other.description == description &&
        other.location == location &&
        other.timestamp == timestamp &&
        other.recordingUrl == recordingUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        description.hashCode ^
        location.hashCode ^
        timestamp.hashCode ^
        recordingUrl.hashCode;
  }
}