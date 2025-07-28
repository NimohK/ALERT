import 'package:flutter/material.dart';

class EmergencyDirectoryScreen extends StatelessWidget {
  const EmergencyDirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contacts = [
      {'icon': Icons.local_police, 'name': 'Police', 'phone': '100'},
      {'icon': Icons.local_hospital, 'name': 'Ambulance', 'phone': '101'},
      {'icon': Icons.local_fire_department, 'name': 'Fire', 'phone': '102'},
      {'icon': Icons.groups, 'name': 'Watch Group', 'phone': '103'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Directory')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: contacts.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                child: Icon(contact['icon'] as IconData, color: Theme.of(context).colorScheme.secondary),
              ),
              title: Text(contact['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Phone: ${contact['phone']}'),
              trailing: IconButton(
                icon: const Icon(Icons.phone, color: Colors.green),
                onPressed: () {
                  // No real call, just a mockup
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Calling ${contact['name']} (mock)')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
} 