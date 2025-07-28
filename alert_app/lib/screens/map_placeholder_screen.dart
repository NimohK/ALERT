import 'package:flutter/material.dart';

class MapPlaceholderScreen extends StatelessWidget {
  const MapPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Map (Coming Soon)')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.map, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('Map integration coming in future updates.', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
} 