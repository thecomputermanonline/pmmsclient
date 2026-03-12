import 'package:flutter/material.dart';
import 'package:realestate_app/screens/property_listing_screen.dart';
import 'package:realestate_app/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_screen.dart';
import 'package:realestate_app/screens/property.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  String city = '';

  String budget = '';

  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("jwt_token");

    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLogin(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          //PropertyListingPage
          return PropertyListingPage(city: city, budget: budget);
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}
