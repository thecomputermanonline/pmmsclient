import 'package:flutter/material.dart';
import '../services/user_session_service.dart';
import '../../features/splash_screen.dart';
import '../../features/navigation/main_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    if (UserSessionService.isLoggedIn) {
      return const MainScreen();
    }

    return const SplashScreen();
  }
}
