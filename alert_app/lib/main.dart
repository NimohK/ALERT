import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const AlertApp());
}

class AlertApp extends StatelessWidget {
  const AlertApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alert App',
      theme: ThemeData(
        primaryColor: const Color(0xFFb76e79),
        scaffoldBackgroundColor: const Color(0xFFf4d7d7),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFb76e79),
          primary: const Color(0xFFb76e79),
          secondary: const Color(0xFFf4d7d7),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFb76e79),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFb76e79),
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class Alert {
  final String description;
  final String type;
  final DateTime timestamp;
  final String location;
  final String status;

  Alert({
    required this.description,
    required this.type,
    required this.timestamp,
    required this.location,
    required this.status,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Alert> _alerts = [
    Alert(
      description: 'Suspicious person spotted',
      type: 'Break-in',
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      location: '123 Main St',
      status: 'Active',
    ),
    Alert(
      description: 'Fire in apartment',
      type: 'Fire',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      location: '456 Oak Ave',
      status: 'Resolved',
    ),
  ];

  void _showNewAlertDialog() async {
    final newAlert = await showDialog<Alert>(
      context: context,
      builder: (context) => NewAlertDialog(),
    );
    if (newAlert != null) {
      setState(() {
        _alerts.insert(0, newAlert);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Alerts'),
      ),
      body: ListView.builder(
        itemCount: _alerts.length,
        itemBuilder: (context, index) {
          final alert = _alerts[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: Icon(Icons.warning, color: Theme.of(context).primaryColor),
              title: Text(alert.type),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(alert.description),
                  Text('Location: ${alert.location}'),
                  Text('Status: ${alert.status}'),
                  Text(DateFormat('yyyy-MM-dd HH:mm').format(alert.timestamp)),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewAlertDialog,
        child: const Icon(Icons.add_alert),
        tooltip: 'Send New Alert',
      ),
    );
  }
}

class NewAlertDialog extends StatefulWidget {
  @override
  State<NewAlertDialog> createState() => _NewAlertDialogState();
}

class _NewAlertDialogState extends State<NewAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  String _description = '';
  String _type = 'Break-in';
  final List<String> _types = ['Break-in', 'Fire', 'Domestic', 'Other'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Send New Alert'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              onChanged: (val) => _description = val,
              validator: (val) => val == null || val.isEmpty ? 'Enter a description' : null,
            ),
            DropdownButtonFormField<String>(
              value: _type,
              items: _types.map((type) => DropdownMenuItem(
                value: type,
                child: Text(type),
              )).toList(),
              onChanged: (val) => setState(() => _type = val ?? 'Break-in'),
              decoration: const InputDecoration(labelText: 'Incident Type'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFb76e79),
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final alert = Alert(
                description: _description,
                type: _type,
                timestamp: DateTime.now(),
                location: 'Current Location', // Placeholder
                status: 'Active',
              );
              Navigator.of(context).pop(alert);
            }
          },
          child: const Text('Send'),
        ),
      ],
    );
  }
}
