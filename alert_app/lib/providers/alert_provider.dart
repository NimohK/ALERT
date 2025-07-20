import 'package:flutter/material.dart';
import '../models/alert.dart';

class AlertProvider extends ChangeNotifier {
  List<Alert> _alerts = [];

  List<Alert> get alerts => _alerts;

  // TODO: Integrate with Firestore
  void fetchAlerts() {
    // Placeholder for fetching alerts from Firestore
  }

  void addAlert(Alert alert) {
    _alerts.insert(0, alert);
    // TODO: Add alert to Firestore
    notifyListeners();
  }
} 