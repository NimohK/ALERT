import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/alert_model.dart';

/// Service class for Firebase Firestore operations
class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Collection reference for alerts
  CollectionReference get alertsCollection => _firestore.collection('alerts');

  /// Submit a new alert to Firestore
  Future<String> submitAlert(AlertModel alert) async {
    try {
      DocumentReference docRef = await alertsCollection.add(alert.toFirestore());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to submit alert: $e');
    }
  }

  /// Get all alerts ordered by timestamp (newest first)
  Stream<List<AlertModel>> getAlerts() {
    return alertsCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return AlertModel.fromFirestore(doc);
      }).toList();
    });
  }

  /// Get alerts with pagination
  Future<List<AlertModel>> getAlertsPaginated({
    int limit = 20,
    DocumentSnapshot? lastDocument,
  }) async {
    try {
      Query query = alertsCollection
          .orderBy('timestamp', descending: true)
          .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      QuerySnapshot snapshot = await query.get();
      return snapshot.docs.map((doc) {
        return AlertModel.fromFirestore(doc);
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch alerts: $e');
    }
  }

  /// Delete an alert (for admin purposes in future)
  Future<void> deleteAlert(String alertId) async {
    try {
      await alertsCollection.doc(alertId).delete();
    } catch (e) {
      throw Exception('Failed to delete alert: $e');
    }
  }

  /// Update an alert (for admin purposes in future)
  Future<void> updateAlert(String alertId, Map<String, dynamic> updates) async {
    try {
      await alertsCollection.doc(alertId).update(updates);
    } catch (e) {
      throw Exception('Failed to update alert: $e');
    }
  }
}