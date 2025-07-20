import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

/// Community chat screen with sample messages (static for MVP)
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  // Sample chat messages for MVP
  final List<ChatMessage> _sampleMessages = const [
    ChatMessage(
      sender: 'Community Admin',
      message: 'Welcome to the community safety chat! Stay alert and keep each other safe.',
      timestamp: '2 hours ago',
      isAdmin: true,
    ),
    ChatMessage(
      sender: 'Sarah M.',
      message: 'Thanks everyone for the quick response to the alert earlier. Community working together! 🙏',
      timestamp: '1 hour ago',
      isAdmin: false,
    ),
    ChatMessage(
      sender: 'Mike K.',
      message: 'Has anyone seen increased patrol activity in the area? Feeling much safer.',
      timestamp: '45 minutes ago',
      isAdmin: false,
    ),
    ChatMessage(
      sender: 'Lisa R.',
      message: 'Remember to keep your outdoor lights on during these times. Every bit helps!',
      timestamp: '30 minutes ago',
      isAdmin: false,
    ),
    ChatMessage(
      sender: 'Community Admin',
      message: 'Monthly community meeting scheduled for next week. More details to follow.',
      timestamp: '15 minutes ago',
      isAdmin: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.communityChat),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Add chat options (mute, search, etc.)
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          // Coming Soon Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: AppColors.info.withOpacity(0.1),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.info,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Full chat functionality coming soon. Below are sample community messages.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.info,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _sampleMessages.length,
              itemBuilder: (context, index) {
                final message = _sampleMessages[index];
                return _buildMessageBubble(context, message);
              },
            ),
          ),
          
          // Message Input (disabled for MVP)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border(
                top: BorderSide(color: AppColors.divider),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'Type a message... (Coming soon)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: null,
                    icon: const Icon(
                      Icons.send,
                      color: AppColors.textLight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sender and timestamp
          Row(
            children: [
              Text(
                message.sender,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: message.isAdmin ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
              if (message.isAdmin) ...[
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'ADMIN',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textLight,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              const Spacer(),
              Text(
                message.timestamp,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          
          // Message content
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: message.isAdmin 
                  ? AppColors.primary.withOpacity(0.1)
                  : AppColors.cardBackground,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: message.isAdmin 
                    ? AppColors.primary.withOpacity(0.3)
                    : AppColors.divider,
              ),
            ),
            child: Text(
              message.message,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

/// Model class for chat messages
class ChatMessage {
  final String sender;
  final String message;
  final String timestamp;
  final bool isAdmin;

  const ChatMessage({
    required this.sender,
    required this.message,
    required this.timestamp,
    required this.isAdmin,
  });
}