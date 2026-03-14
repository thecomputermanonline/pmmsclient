import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_profile_model.dart';
import 'api_service.dart';

class ProfileService {
  /// Load profile from API and cache locally
  static Future<UserProfileModel?> getProfile() async {
    final profile = await ApiService.loadUserProfile();

    if (profile != null) {
      await _cacheProfile(profile);
    }

    return profile;
  }

  /// Update profile via API and cache locally
  static Future<bool> updateProfile(UserProfileModel profile) async {
    final success = await ApiService.updateUserProfile(profile);

    if (success) {
      await _cacheProfile(profile);
    }

    return success;
  }

  /// Load cached profile if offline
  static Future<UserProfileModel?> getCachedProfile() async {
    final prefs = await SharedPreferences.getInstance();

    final email = prefs.getString("email");
    if (email == null) return null;

    return UserProfileModel(
      firstName: prefs.getString("firstName") ?? "",
      lastName: prefs.getString("lastName") ?? "",
      email: email,
      phone: prefs.getString("phone") ?? "",
      userType: prefs.getString("userType") ?? "Student",
      city: prefs.getString("city") ?? "Port Louis",
      budget: prefs.getString("budget") ?? "",
    );
  }

  /// Save profile to local storage
  static Future<void> _cacheProfile(UserProfileModel profile) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("firstName", profile.firstName);
    await prefs.setString("lastName", profile.lastName);
    await prefs.setString("email", profile.email);
    await prefs.setString("phone", profile.phone);
    await prefs.setString("userType", profile.userType);
    await prefs.setString("city", profile.city);
    await prefs.setString("budget", profile.budget);
  }
}
