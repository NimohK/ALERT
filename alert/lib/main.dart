import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'constants/app_colors.dart';
import 'constants/app_strings.dart';
import 'providers/alert_provider.dart';
import 'providers/emergency_contacts_provider.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase (for production, you would need to add Firebase config files)
  // For this MVP, we'll handle the case where Firebase might not be configured
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
    // Continue without Firebase for development
  }
  
  runApp(const AlertApp());
}

class AlertApp extends StatelessWidget {
  const AlertApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AlertProvider()..initialize()),
        ChangeNotifierProvider(create: (_) => EmergencyContactsProvider()..initialize()),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: _createMaterialColor(AppColors.primary),
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textLight,
            elevation: 2,
            centerTitle: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonPrimary,
              foregroundColor: AppColors.textLight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          cardTheme: CardThemeData(
            color: AppColors.cardBackground,
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.surface,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textSecondary,
            type: BottomNavigationBarType.fixed,
          ),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            headlineMedium: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
            ),
            bodyMedium: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          useMaterial3: true,
        ),
        home: const MainScreen(),
      ),
    );
  }

  /// Helper method to create MaterialColor from Color
  MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final colorValue = color.value;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      final int r = ((colorValue >> 16) & 0xFF);
      final int g = ((colorValue >> 8) & 0xFF);
      final int b = (colorValue & 0xFF);
      
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        (r + ((ds < 0 ? r : (255 - r)) * ds)).round(),
        (g + ((ds < 0 ? g : (255 - g)) * ds)).round(),
        (b + ((ds < 0 ? b : (255 - b)) * ds)).round(),
        1,
      );
    }
    return MaterialColor(colorValue, swatch);
  }
}
