import 'package:flutter/material.dart';
import '../models/alert.dart';

class AlertCard extends StatelessWidget {
  final Alert alert;
  const AlertCard({Key? key, required this.alert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          alert.type == 'Break-in'
              ? Icons.door_front_door
              : alert.type == 'Fire'
                  ? Icons.local_fire_department
                  : alert.type == 'Domestic'
                      ? Icons.family_restroom
                      : Icons.warning,
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(alert.type, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(alert.description),
            Text('Location: ${alert.location}'),
            Text('Time: ${alert.time.toLocal()}'),
          ],
        ),
      ),
    );
  }
} 