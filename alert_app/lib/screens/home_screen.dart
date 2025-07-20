import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/alert_provider.dart';
import '../widgets/alert_card.dart';
import 'send_alert_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final alerts = context.watch<AlertProvider>().alerts;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Alerts'),
      ),
      body: alerts.isEmpty
          ? const Center(child: Text('No alerts yet.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: alerts.length,
              itemBuilder: (context, index) => AlertCard(alert: alerts[index]),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SendAlertScreen()),
          );
        },
        child: const Icon(Icons.add_alert),
        tooltip: 'Send Alert',
      ),
    );
  }
} 