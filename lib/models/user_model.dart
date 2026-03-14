import 'user_profile_model.dart';

class UserModel {
  final String id;
  final String? email;
  final bool? emailConfirmed;
  final UserProfileModel? profile;

  UserModel({
    required this.id,
    this.email,
    this.emailConfirmed,
    this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['userId'],
      // email: json['email'],
      // emailConfirmed: json['IsProfileComplete'] ?? false,
      // profile: json['profile'] != null
      //     ? UserProfileModel.fromJson(json['profile'])
      //     : null,
    );
  }
}
