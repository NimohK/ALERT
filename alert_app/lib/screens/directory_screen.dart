import 'package:flutter/material.dart';

class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Directory'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.local_police),
            title: Text('Police'),
            subtitle: Text('999'),
            trailing: Text('Law Enforcement'),
          ),
          ListTile(
            leading: Icon(Icons.local_fire_department),
            title: Text('Fire Department'),
            subtitle: Text('998'),
            trailing: Text('Fire Service'),
          ),
          ListTile(
            leading: Icon(Icons.local_hospital),
            title: Text('Ambulance'),
            subtitle: Text('997'),
            trailing: Text('Medical'),
          ),
        ],
      ),
    );
  }
} 