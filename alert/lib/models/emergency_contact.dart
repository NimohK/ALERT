/// Model class representing an emergency contact
class EmergencyContact {
  final String id;
  final String name;
  final String phoneNumber;
  final String serviceType;
  final String? description;

  EmergencyContact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.serviceType,
    this.description,
  });

  /// Create a copy of EmergencyContact with updated fields
  EmergencyContact copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? serviceType,
    String? description,
  }) {
    return EmergencyContact(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      serviceType: serviceType ?? this.serviceType,
      description: description ?? this.description,
    );
  }

  @override
  String toString() {
    return 'EmergencyContact(id: $id, name: $name, phoneNumber: $phoneNumber, serviceType: $serviceType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EmergencyContact &&
        other.id == id &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.serviceType == serviceType &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode ^
        serviceType.hashCode ^
        description.hashCode;
  }
}