import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';

class UserSessionService {
  static const _tokenKey = "jwt_token";
  static const _userKey = "current_user";

  static String? _token;
  static UserModel? _currentUser;

  /// Initialize session from local storage
  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    _token = prefs.getString(_tokenKey);

    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      _currentUser = UserModel.fromJson(jsonDecode(userJson));
    }
  }

  /// Save session after login
  static Future<void> saveSession(String token, UserModel user) async {
    final prefs = await SharedPreferences.getInstance();

    _token = token;
    _currentUser = user;

    await prefs.setString(_tokenKey, token);
    await prefs.setString(
        _userKey,
        jsonEncode({
          "id": user.id,
          "email": user.email,
          "emailConfirmed": user.emailConfirmed
        }));
  }

  /// Get JWT token
  static String? get token => _token;

  /// Get current user
  static UserModel? get currentUser => _currentUser;

  /// Check if logged in
  static bool get isLoggedIn => _token != null;

  /// Clear session (logout)
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    _token = null;
    _currentUser = null;

    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }
}
