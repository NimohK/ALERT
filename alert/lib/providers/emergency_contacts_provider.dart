import 'package:flutter/foundation.dart';
import '../models/emergency_contact.dart';

/// Provider class for managing emergency contacts
class EmergencyContactsProvider with ChangeNotifier {
  List<EmergencyContact> _contacts = [];

  // Getter
  List<EmergencyContact> get contacts => _contacts;

  /// Initialize with static emergency contacts data
  void initialize() {
    _contacts = [
      EmergencyContact(
        id: '1',
        name: 'Police Emergency',
        phoneNumber: '911',
        serviceType: 'Police',
        description: 'Emergency police services',
      ),
      EmergencyContact(
        id: '2',
        name: 'Fire Department',
        phoneNumber: '911',
        serviceType: 'Fire',
        description: 'Fire emergency and rescue services',
      ),
      EmergencyContact(
        id: '3',
        name: 'Medical Emergency',
        phoneNumber: '911',
        serviceType: 'Medical',
        description: 'Ambulance and medical emergency services',
      ),
      EmergencyContact(
        id: '4',
        name: 'Local Police Station',
        phoneNumber: '+1-555-0101',
        serviceType: 'Police',
        description: 'Non-emergency police line',
      ),
      EmergencyContact(
        id: '5',
        name: 'Community Security',
        phoneNumber: '+1-555-0102',
        serviceType: 'Security',
        description: 'Local community security patrol',
      ),
      EmergencyContact(
        id: '6',
        name: 'Poison Control',
        phoneNumber: '+1-800-222-1222',
        serviceType: 'Medical',
        description: 'Poison control center hotline',
      ),
      EmergencyContact(
        id: '7',
        name: 'Domestic Violence Hotline',
        phoneNumber: '+1-800-799-7233',
        serviceType: 'Support',
        description: 'National domestic violence hotline',
      ),
      EmergencyContact(
        id: '8',
        name: 'Crisis Text Line',
        phoneNumber: 'Text HOME to 741741',
        serviceType: 'Support',
        description: 'Crisis support via text message',
      ),
      EmergencyContact(
        id: '9',
        name: 'Animal Control',
        phoneNumber: '+1-555-0103',
        serviceType: 'Animal Control',
        description: 'Animal control and wildlife services',
      ),
      EmergencyContact(
        id: '10',
        name: 'Utilities Emergency',
        phoneNumber: '+1-555-0104',
        serviceType: 'Utilities',
        description: 'Gas, water, and electricity emergencies',
      ),
    ];
    notifyListeners();
  }

  /// Get contacts by service type
  List<EmergencyContact> getContactsByType(String serviceType) {
    return _contacts.where((contact) => contact.serviceType == serviceType).toList();
  }

  /// Get all unique service types
  List<String> getServiceTypes() {
    return _contacts.map((contact) => contact.serviceType).toSet().toList();
  }

  /// Search contacts by name or service type
  List<EmergencyContact> searchContacts(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _contacts.where((contact) {
      return contact.name.toLowerCase().contains(lowercaseQuery) ||
             contact.serviceType.toLowerCase().contains(lowercaseQuery) ||
             (contact.description?.toLowerCase().contains(lowercaseQuery) ?? false);
    }).toList();
  }
}