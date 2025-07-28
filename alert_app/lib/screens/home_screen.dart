import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts = [
      {
        'icon': Icons.warning,
        'title': 'Break-in Reported',
        'description': 'Suspicious activity noticed near Main St.',
        'location': 'Main St, Block 5',
        'time': '2 min ago',
      },
      {
        'icon': Icons.local_fire_department,
        'title': 'Fire Alert',
        'description': 'Smoke seen in apartment complex.',
        'location': 'Sunset Apartments',
        'time': '10 min ago',
      },
      {
        'icon': Icons.home,
        'title': 'Domestic Disturbance',
        'description': 'Loud noises reported by neighbors.',
        'location': 'Elm St, House 12',
        'time': '20 min ago',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('ALERT')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          final alert = alerts[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Icon(alert['icon'] as IconData, color: Theme.of(context).colorScheme.primary),
              ),
              title: Text(alert['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(alert['description'] as String),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Theme.of(context).colorScheme.secondary),
                      const SizedBox(width: 4),
                      Text(alert['location'] as String, style: const TextStyle(fontSize: 12)),
                      const Spacer(),
                      Icon(Icons.access_time, size: 16, color: Colors.grey),
                      const SizedBox(width: 2),
                      Text(alert['time'] as String, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigation to Send Alert handled in main navigation
        },
        child: const Icon(Icons.add_alert),
        tooltip: 'Send Alert',
      ),
    );
  }
} 