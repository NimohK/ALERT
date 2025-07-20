import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../providers/alert_provider.dart';
import '../widgets/alert_card.dart';
import 'send_alert_screen.dart';

/// Home screen showing alerts feed and send alert button
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(AppStrings.appName),
            Text(
              AppStrings.appSubtitle,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: Consumer<AlertProvider>(
        builder: (context, alertProvider, child) {
          return Column(
            children: [
              // Send Alert Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SendAlertScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.warning, color: AppColors.textLight),
                  label: const Text(AppStrings.sendAlert),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonEmergency,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              
              // Section Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      AppStrings.recentAlerts,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => alertProvider.refreshAlerts(),
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              ),
              
              // Alerts List
              Expanded(
                child: _buildAlertsList(context, alertProvider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAlertsList(BuildContext context, AlertProvider alertProvider) {
    if (alertProvider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (alertProvider.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              alertProvider.error!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => alertProvider.refreshAlerts(),
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      );
    }

    if (alertProvider.alerts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.noAlertsMessage,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => alertProvider.refreshAlerts(),
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: alertProvider.alerts.length,
        itemBuilder: (context, index) {
          final alert = alertProvider.alerts[index];
          return AlertCard(alert: alert);
        },
      ),
    );
  }
}