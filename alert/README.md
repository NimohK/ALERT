# ALERT - Community Safety & Emergency Alert Platform

A Flutter mobile application for community safety and emergency alerts, featuring real-time alert sharing, emergency contacts directory, and community contribution platform.

## Features

### ✅ MVP Features Implemented

#### 1. Home Screen with Alerts Feed
- List recent community alerts with type, description, location, and timestamp
- "Send Alert" button for quick emergency reporting
- Real-time updates with Firebase Firestore integration
- Pull-to-refresh functionality

#### 2. Send Alert Form
- Incident type selection (Break-in, Fire, Domestic, Other)
- Description and location entry (manual text input)
- Audio recording placeholder for critical incidents (Break-in, Fire, Domestic)
- Form validation and Firebase storage

#### 3. Community Chat Screen
- Sample chat messages (static for MVP)
- Admin and community member message distinction
- Modern chat UI design
- Coming soon banner for full functionality

#### 4. Local Emergency Directory
- Static list of emergency contacts
- Search and filter by service type
- Direct calling functionality via URL launcher
- Service type categorization with icons and colors

#### 5. Payment & Mobile Banking Feature
- "Contribute to Community Security" screen
- Amount entry with quick selection buttons
- Payment method selection (Mobile Money, Card, Bank Transfer)
- Sample payment flow with success/failure responses
- Placeholder for Flutterwave and MPesa integration

#### 6. Bottom Navigation Bar
- Home, Chat, Directory, Contribute, and Map tabs
- Consistent navigation experience

#### 7. Map Integration Placeholder
- "Map (Coming Soon)" screen
- Feature preview with upcoming capabilities
- Integration roadmap display

## Technical Implementation

### Architecture & State Management
- **Clean Architecture**: Modular code organization with separate layers
- **Provider Pattern**: State management using Flutter Provider package
- **Repository Pattern**: Data layer abstraction with Firebase service

### Firebase Integration
- **Firestore**: Real-time alerts storage and retrieval
- **Error Handling**: Graceful fallback when Firebase is not configured
- **Future Extensions**: Authentication, push notifications, cloud functions

### UI/UX Design
- **Material Design 3**: Modern Flutter UI components
- **Custom Color Scheme**: 
  - Primary: #1A237E (Deep Blue - Trust & Authority)
  - Accent: #F44336 (Red - Emergency/Alert)
  - Success: #4CAF50 (Green - Positive Actions)
  - Background: #F5F5F5 (Neutral)
- **Responsive Design**: Adaptive layouts for various screen sizes
- **Accessibility**: Screen reader friendly components

### Code Quality
- **Linting**: Flutter recommended lints
- **Type Safety**: Comprehensive type annotations
- **Documentation**: Inline code documentation
- **Error Handling**: Comprehensive error states and user feedback

## Project Structure

```
lib/
├── constants/
│   ├── app_colors.dart          # Color scheme constants
│   └── app_strings.dart         # Text content constants
├── models/
│   ├── alert_model.dart         # Alert data model
│   └── emergency_contact.dart   # Emergency contact model
├── providers/
│   ├── alert_provider.dart      # Alert state management
│   └── emergency_contacts_provider.dart
├── screens/
│   ├── main_screen.dart         # Main navigation screen
│   ├── home_screen.dart         # Alerts feed
│   ├── send_alert_screen.dart   # Alert submission form
│   ├── chat_screen.dart         # Community chat
│   ├── directory_screen.dart    # Emergency contacts
│   ├── contribute_screen.dart   # Payment/contributions
│   └── map_screen.dart          # Map placeholder
├── services/
│   ├── firebase_service.dart    # Firestore operations
│   └── payment_service.dart     # Payment processing
├── widgets/
│   └── alert_card.dart          # Alert display component
└── main.dart                    # App entry point
```

## Dependencies

### Core Dependencies
- `flutter`: Framework
- `provider`: State management
- `firebase_core`: Firebase initialization
- `cloud_firestore`: Real-time database
- `url_launcher`: Phone calling functionality
- `intl`: Date/time formatting
- `http`: HTTP requests (future payment APIs)

### Dev Dependencies
- `flutter_test`: Testing framework
- `flutter_lints`: Code quality rules

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio or VS Code
- Firebase project (optional for MVP)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd alert
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Firebase Setup (Optional)

For full functionality with real-time alerts:

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
2. Add your Android/iOS app to the project
3. Download and add configuration files:
   - `android/app/google-services.json` (Android)
   - `ios/Runner/GoogleService-Info.plist` (iOS)
4. Enable Firestore Database in the Firebase console

The app will run without Firebase configuration using local data for development.

## Payment Gateway Integration

### Current Implementation
- Mock payment service with sample responses
- Support for three payment methods:
  - Mobile Money (MPesa ready)
  - Credit/Debit Cards
  - Bank Transfer

### Future Integration
- **Flutterwave**: Card payments, bank transfers
- **MPesa**: Mobile money payments for Kenya/Africa
- **Stripe**: International card processing

### Integration Comments
Payment service includes comprehensive comments for future gateway integration:
```dart
// TODO: Integrate with Flutterwave Card API
// TODO: Integrate with MPesa API  
// TODO: Implement actual payment verification
```

## Future Enhancements

### Phase 2 Features
- **Real-time Chat**: WebSocket-based community messaging
- **Push Notifications**: Instant alert notifications
- **User Authentication**: User accounts and profiles
- **Map Integration**: Google Maps with real-time alert locations
- **Audio Recording**: Actual audio evidence recording
- **Admin Dashboard**: Web-based alert management

### Phase 3 Features
- **Machine Learning**: Automatic alert categorization
- **Geofencing**: Location-based alert filtering
- **Social Features**: User verification, ratings
- **Analytics**: Community safety insights
- **Multi-language**: Localization support

## Testing

### Run Tests
```bash
flutter test
```

### Test Coverage
- Widget tests for main components
- Unit tests for providers and services
- Integration tests for user flows

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style
- Follow Flutter/Dart conventions
- Use meaningful variable and function names
- Add documentation for public APIs
- Ensure all tests pass before submitting

## Security Considerations

- **Data Encryption**: All data transmitted over HTTPS
- **Input Validation**: Comprehensive form validation
- **Error Handling**: No sensitive data in error messages
- **Authentication**: Prepared for secure user authentication
- **Privacy**: Minimal data collection, user consent

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support, email support@alert-community.app or join our community Discord.

## Acknowledgments

- Flutter team for the excellent framework
- Firebase for real-time database capabilities
- Material Design for UI/UX guidelines
- The open-source community for inspiration

---

**Built with ❤️ for community safety**
