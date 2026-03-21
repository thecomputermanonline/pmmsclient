import 'package:flutter/material.dart';
import 'core/services/user_session_service.dart';
import 'core/auth/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserSessionService.initialize();
  runApp(const IslandHomes());
}

class IslandHomes extends StatelessWidget {
  const IslandHomes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Island Homes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // brightness: Brightness.dark, // dark base theme
        primaryColor: const Color(0xFF35AFBA), // brand color
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.white, // default accent color
        ),

        // 🔹 Radios white
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(Colors.white),
        ),

        // 🔹 Checkboxes white
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(Colors.white),
        ),

        // 🔹 Switch white
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(Colors.white),
          trackColor: MaterialStateProperty.all(Colors.white24),
        ),

        // 🔹 Elevated Buttons brand color + rounded
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF35AFBA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minimumSize: const Size.fromHeight(50),
          ),
        ),

        // 🔹 Text fields styling globally
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          labelStyle: const TextStyle(color: Colors.white70),
          hintStyle: const TextStyle(color: Colors.white38),
        ),
      ),
      home: const AuthGate(),
    );
  }
}
