import 'package:flutter/material.dart';
import '../constants/app_strings.dart';
import 'home_screen.dart';
import 'chat_screen.dart';
import 'directory_screen.dart';
import 'contribute_screen.dart';
import 'map_screen.dart';

/// Main screen with bottom navigation
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ChatScreen(),
    const DirectoryScreen(),
    const ContributeScreen(),
    const MapScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.homeTab,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: AppStrings.chatTab,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone),
            label: AppStrings.directoryTab,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: AppStrings.contributeTab,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: AppStrings.mapTab,
          ),
        ],
      ),
    );
  }
}