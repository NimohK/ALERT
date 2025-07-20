import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Chat'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            title: Text('Alice'),
            subtitle: Text('Stay safe everyone!'),
          ),
          ListTile(
            title: Text('Bob'),
            subtitle: Text('Saw a fire truck near Main St.'),
          ),
          ListTile(
            title: Text('Carol'),
            subtitle: Text('Thanks for the alert!'),
          ),
        ],
      ),
    );
  }
} 