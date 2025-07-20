import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../providers/alert_provider.dart';

/// Screen for sending new community alerts
class SendAlertScreen extends StatefulWidget {
  const SendAlertScreen({super.key});

  @override
  State<SendAlertScreen> createState() => _SendAlertScreenState();
}

class _SendAlertScreenState extends State<SendAlertScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  
  String? _selectedIncidentType;
  bool _isSubmitting = false;

  final List<String> _incidentTypes = [
    AppStrings.breakInAlert,
    AppStrings.fireAlert,
    AppStrings.domesticAlert,
    AppStrings.otherAlert,
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.sendAlertTitle),
      ),
      body: Consumer<AlertProvider>(
        builder: (context, alertProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Incident Type Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedIncidentType,
                    decoration: const InputDecoration(
                      labelText: AppStrings.incidentType,
                      hintText: AppStrings.selectIncidentType,
                    ),
                    items: _incidentTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedIncidentType = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.requiredField;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Description Field
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.description,
                      hintText: AppStrings.descriptionHint,
                    ),
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppStrings.requiredField;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Location Field
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.location,
                      hintText: AppStrings.locationHint,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppStrings.requiredField;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  
                  // Recording Section (for critical incidents)
                  if (_shouldShowRecording()) ...[
                    _buildRecordingSection(alertProvider),
                    const SizedBox(height: 24),
                  ],
                  
                  // Submit Button
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitAlert,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonEmergency,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.textLight,
                              ),
                            ),
                          )
                        : const Text(
                            AppStrings.submitAlert,
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool _shouldShowRecording() {
    return _selectedIncidentType == AppStrings.breakInAlert ||
           _selectedIncidentType == AppStrings.fireAlert ||
           _selectedIncidentType == AppStrings.domesticAlert;
  }

  Widget _buildRecordingSection(AlertProvider alertProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Text(
            'Recording Evidence',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'For ${_selectedIncidentType?.toLowerCase()} incidents, you can record audio evidence.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          
          if (alertProvider.isRecording) ...[
            const Icon(
              Icons.mic,
              size: 48,
              color: AppColors.accent,
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.recording,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => alertProvider.stopRecording(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
              ),
              child: const Text(AppStrings.stopRecording),
            ),
          ] else ...[
            const Icon(
              Icons.mic_none,
              size: 48,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => alertProvider.startRecording(),
              icon: const Icon(Icons.mic),
              label: const Text('Start Recording'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _submitAlert() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final alertProvider = Provider.of<AlertProvider>(context, listen: false);
    
    final success = await alertProvider.submitAlert(
      type: _selectedIncidentType!,
      description: _descriptionController.text.trim(),
      location: _locationController.text.trim(),
    );

    setState(() {
      _isSubmitting = false;
    });

    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Alert submitted successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.of(context).pop();
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(alertProvider.error ?? 'Failed to submit alert'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}