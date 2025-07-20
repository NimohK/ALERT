import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../models/alert_model.dart';

/// Widget to display an individual alert in a card format
class AlertCard extends StatelessWidget {
  final AlertModel alert;

  const AlertCard({
    super.key,
    required this.alert,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with type and timestamp
            Row(
              children: [
                _buildAlertTypeChip(),
                const Spacer(),
                Text(
                  _formatTimestamp(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Description
            Text(
              alert.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            
            // Location
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    alert.location,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            
            // Recording indicator (if available)
            if (alert.recordingUrl != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.mic,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Audio recording available',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAlertTypeChip() {
    Color chipColor;
    IconData chipIcon;

    switch (alert.type) {
      case AppStrings.breakInAlert:
        chipColor = AppColors.accent;
        chipIcon = Icons.lock_outline;
        break;
      case AppStrings.fireAlert:
        chipColor = AppColors.warning;
        chipIcon = Icons.local_fire_department;
        break;
      case AppStrings.domesticAlert:
        chipColor = AppColors.error;
        chipIcon = Icons.home;
        break;
      default:
        chipColor = AppColors.info;
        chipIcon = Icons.info_outline;
    }

    return Chip(
      avatar: Icon(
        chipIcon,
        size: 16,
        color: AppColors.textLight,
      ),
      label: Text(
        alert.type,
        style: const TextStyle(
          color: AppColors.textLight,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: chipColor,
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }

  String _formatTimestamp() {
    final now = DateTime.now();
    final difference = now.difference(alert.timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d, y').format(alert.timestamp);
    }
  }
}