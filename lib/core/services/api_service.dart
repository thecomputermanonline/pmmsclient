/*
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile.dart';

class ApiService {
  // Replace with your actual backend URL
  static const String baseUrl = "http://localhost:5000/api";

  /// Sends OTP to the given email.
  /// Returns true if successful, false otherwise.
  static Future<bool> sendOtp(String email) async {
    try {
      final Uri url = Uri.parse("$baseUrl/Account/RequestEmailLogin");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      // Debug info
      print("OTP API Response: ${response.statusCode} ${response.body}");

      if (response.statusCode == 200) {
        // Optional: Check backend JSON message
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data.containsKey('success') && data['success'] == true) {
          return true;
        }
        // Fallback if backend does not return 'success' field
        return true;
      } else {
        // Non-200 HTTP code
        print("Failed to send OTP. Status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      // Network or JSON parsing error
      print("Error sending OTP: $e");
      return false;
    }
  }

  static Future<dynamic> fetchProperties() async {}

  static Future<bool> verifyOtp(String email, String otp) async {
    // return true;
    try {
      final Uri url = Uri.parse("$baseUrl/Account/VerifyEmail");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "code": otp,
        }),
      );

      print("Verify OTP Response: ${response.statusCode} ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["success"] == true) {
          // Optional: store JWT token
          String token = data["token"];
          print("Login token: $token");

          final userid = data['userId'];

          // Store token for future requests (e.g., shared_preferences)
          await SharedPreferences.getInstance()
              .then((prefs) => prefs.setString('jwt_token', token));

          return true;
        }
      }

      return false;
    } catch (e) {
      print("OTP verification error: $e");
      return false;
    }

    //
  }

  static Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) return null; // user not logged in

    final response = await http.get(
      Uri.parse("$baseUrl/UserProfile/me"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Failed to load user: ${response.statusCode}");
      print(response.body);
      return null;
    }
  }
}
*/

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_session_service.dart';
import '../../models/auth_response_model.dart';
import '../../models/user_profile_model.dart';

class ApiService {
  static const String baseUrl = "http://localhost:5000/api";

  /// Get token
  static Future<String?> _getToken() async {
    return UserSessionService.token;
  }

  /// Authenticated GET request
  static Future<http.Response> _authGet(String endpoint) async {
    final token = await _getToken();

    return http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
  }

  /// Authenticated POST request
  static Future<http.Response> _authPost(
      String endpoint, Map<String, dynamic> body) async {
    final token = await _getToken();

    return http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );
  }

  /// LOAD USER PROFILE
  static Future<UserProfileModel?> loadUserProfile() async {
    try {
      final response = await _authGet("/UserProfile/me");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserProfileModel.fromJson(data);
      }

      print("Profile load failed: ${response.body}");
      return null;
    } catch (e) {
      print("Profile error: $e");
      return null;
    }
  }

  /// Update User Profile
  static Future<bool> updateUserProfile(UserProfileModel profile) async {
    try {
      final token = await _getToken();
      if (token == null) return false;

      final response = await http.put(
        Uri.parse("$baseUrl/UserProfile"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "firstName": profile.firstName,
          "lastName": profile.lastName,
          "phone": profile.phone,
          "userType": profile.userType,
          "city": profile.city,
          "budget": profile.budget,
        }),
      );

      print("Update Profile Response: ${response.statusCode} ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("Error updating profile: $e");
      return false;
    }
  }

  /// FETCH PROPERTIES
  static Future<List<dynamic>?> fetchProperties() async {
    try {
      final response = await _authGet("/properties");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return null;
    } catch (e) {
      print("Property fetch error: $e");
      return null;
    }
  }

  /// SEND OTP
  static Future<bool> sendOtp(String email) async {
    try {
      final Uri url = Uri.parse("$baseUrl/Account/RequestEmailLogin");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      print("OTP API Response: ${response.statusCode} ${response.body}");

      if (response.statusCode == 200) {
        //final data = jsonDecode(response.body);
        return true;
      }

      return false;
    } catch (e) {
      print("Error sending OTP: $e");
      return false;
    }
  }

  /// VERIFY OTP LOGIN
  static Future<bool> verifyOtp(String email, String otp) async {
    try {
      final Uri url = Uri.parse("$baseUrl/Account/VerifyEmail");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "code": otp,
        }),
      );

      print("Verify OTP Response: ${response.statusCode} ${response.body}");

      if (response.statusCode == 200) {
        final data = AuthResponse.fromJson(jsonDecode(response.body));

        await UserSessionService.saveSession(
          data.token,
          data.user,
        );
        //final data = jsonDecode(response.body);

        return true;
      }

      return false;
    } catch (e) {
      print("OTP verification error: $e");
      return false;
    }
  }
}
