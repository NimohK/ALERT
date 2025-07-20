import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../providers/emergency_contacts_provider.dart';
import '../models/emergency_contact.dart';

/// Emergency directory screen with local emergency contacts
class DirectoryScreen extends StatefulWidget {
  const DirectoryScreen({super.key});

  @override
  State<DirectoryScreen> createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  String _searchQuery = '';
  String? _selectedServiceType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.emergencyDirectory),
      ),
      body: Consumer<EmergencyContactsProvider>(
        builder: (context, contactsProvider, child) {
          final serviceTypes = ['All', ...contactsProvider.getServiceTypes()];
          final filteredContacts = _getFilteredContacts(contactsProvider);

          return Column(
            children: [
              // Search and Filter Section
              Container(
                padding: const EdgeInsets.all(16),
                color: AppColors.surface,
                child: Column(
                  children: [
                    // Search Field
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search contacts...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    
                    // Service Type Filter
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: serviceTypes.length,
                        itemBuilder: (context, index) {
                          final serviceType = serviceTypes[index];
                          final isSelected = serviceType == _selectedServiceType ||
                              (serviceType == 'All' && _selectedServiceType == null);
                          
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Text(serviceType),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedServiceType = 
                                      serviceType == 'All' ? null : serviceType;
                                });
                              },
                              backgroundColor: AppColors.cardBackground,
                              selectedColor: AppColors.primary.withOpacity(0.2),
                              checkmarkColor: AppColors.primary,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              
              // Contacts List
              Expanded(
                child: _buildContactsList(filteredContacts),
              ),
            ],
          );
        },
      ),
    );
  }

  List<EmergencyContact> _getFilteredContacts(EmergencyContactsProvider provider) {
    List<EmergencyContact> contacts = provider.contacts;

    // Filter by service type
    if (_selectedServiceType != null) {
      contacts = provider.getContactsByType(_selectedServiceType!);
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      contacts = provider.searchContacts(_searchQuery);
    }

    return contacts;
  }

  Widget _buildContactsList(List<EmergencyContact> contacts) {
    if (contacts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.contact_phone_outlined,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No contacts found',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return _buildContactCard(contact);
      },
    );
  }

  Widget _buildContactCard(EmergencyContact contact) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _makePhoneCall(contact.phoneNumber),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Service Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getServiceTypeColor(contact.serviceType).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getServiceTypeIcon(contact.serviceType),
                  color: _getServiceTypeColor(contact.serviceType),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              
              // Contact Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      contact.phoneNumber,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (contact.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        contact.description!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              // Service Type Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getServiceTypeColor(contact.serviceType).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  contact.serviceType,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _getServiceTypeColor(contact.serviceType),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              
              // Call Button
              IconButton(
                onPressed: () => _makePhoneCall(contact.phoneNumber),
                icon: const Icon(Icons.phone),
                color: AppColors.success,
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.success.withOpacity(0.1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getServiceTypeIcon(String serviceType) {
    switch (serviceType) {
      case 'Police':
        return Icons.local_police;
      case 'Fire':
        return Icons.local_fire_department;
      case 'Medical':
        return Icons.local_hospital;
      case 'Security':
        return Icons.security;
      case 'Support':
        return Icons.support_agent;
      case 'Animal Control':
        return Icons.pets;
      case 'Utilities':
        return Icons.build;
      default:
        return Icons.phone;
    }
  }

  Color _getServiceTypeColor(String serviceType) {
    switch (serviceType) {
      case 'Police':
        return AppColors.primary;
      case 'Fire':
        return AppColors.accent;
      case 'Medical':
        return AppColors.error;
      case 'Security':
        return AppColors.warning;
      case 'Support':
        return AppColors.success;
      case 'Animal Control':
        return AppColors.info;
      case 'Utilities':
        return AppColors.textSecondary;
      default:
        return AppColors.primary;
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Cannot make phone calls on this device'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error making phone call: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}