import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/alert_provider.dart';
import '../models/alert.dart';

class SendAlertScreen extends StatefulWidget {
  const SendAlertScreen({Key? key}) : super(key: key);

  @override
  State<SendAlertScreen> createState() => _SendAlertScreenState();
}

class _SendAlertScreenState extends State<SendAlertScreen> {
  final _formKey = GlobalKey<FormState>();
  String _type = 'Break-in';
  String _description = '';
  String _location = '';
  bool _isRecording = false;

  void _startRecording() {
    setState(() {
      _isRecording = true;
    });
    // Placeholder for recording logic
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isRecording = false;
      });
    });
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final alert = Alert(
        type: _type,
        description: _description,
        location: _location,
        time: DateTime.now(),
      );
      Provider.of<AlertProvider>(context, listen: false).addAlert(alert);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Alert')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Incident Type'),
              DropdownButtonFormField<String>(
                value: _type,
                items: const [
                  DropdownMenuItem(value: 'Break-in', child: Text('Break-in')),
                  DropdownMenuItem(value: 'Fire', child: Text('Fire')),
                  DropdownMenuItem(value: 'Domestic', child: Text('Domestic')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (value) {
                  setState(() {
                    _type = value!;
                  });
                  if (['Break-in', 'Fire', 'Domestic'].contains(value)) {
                    _startRecording();
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (val) => _description = val ?? '',
                validator: (val) => val == null || val.isEmpty ? 'Enter a description' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location'),
                onSaved: (val) => _location = val ?? '',
                validator: (val) => val == null || val.isEmpty ? 'Enter a location' : null,
              ),
              const SizedBox(height: 24),
              if (_isRecording)
                const Text('Recording... (placeholder)', style: TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                ),
                child: const Text('Send Alert'),
              ),
              const SizedBox(height: 16),
              const Text('// TODO: Integrate Firestore for alert storage', style: TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ),
    );
  }
} 