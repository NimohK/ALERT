import 'package:flutter/foundation.dart';
import '../models/alert_model.dart';
import '../services/firebase_service.dart';

/// Provider class for managing alert state
class AlertProvider with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  
  List<AlertModel> _alerts = [];
  bool _isLoading = false;
  String? _error;
  bool _isRecording = false;

  // Getters
  List<AlertModel> get alerts => _alerts;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isRecording => _isRecording;

  /// Initialize and load alerts
  void initialize() {
    loadAlerts();
  }

  /// Load alerts from Firebase
  void loadAlerts() {
    _isLoading = true;
    _error = null;
    notifyListeners();

    _firebaseService.getAlerts().listen(
      (alerts) {
        _alerts = alerts;
        _isLoading = false;
        _error = null;
        notifyListeners();
      },
      onError: (error) {
        _error = 'Failed to load alerts: $error';
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  /// Submit a new alert
  Future<bool> submitAlert({
    required String type,
    required String description,
    required String location,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final alert = AlertModel(
        id: '', // Will be set by Firestore
        type: type,
        description: description,
        location: location,
        timestamp: DateTime.now(),
      );

      await _firebaseService.submitAlert(alert);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to submit alert: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Start recording (placeholder for audio recording)
  void startRecording() {
    _isRecording = true;
    notifyListeners();
    
    // Simulate recording duration
    Future.delayed(const Duration(seconds: 5), () {
      if (_isRecording) {
        stopRecording();
      }
    });
  }

  /// Stop recording (placeholder for audio recording)
  void stopRecording() {
    _isRecording = false;
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Refresh alerts
  Future<void> refreshAlerts() async {
    loadAlerts();
  }

  /// Get alerts by type
  List<AlertModel> getAlertsByType(String type) {
    return _alerts.where((alert) => alert.type == type).toList();
  }

  /// Get recent alerts (last 24 hours)
  List<AlertModel> getRecentAlerts() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return _alerts.where((alert) => alert.timestamp.isAfter(yesterday)).toList();
  }
}