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
      home: const AuthGate(),
    );
  }
}
