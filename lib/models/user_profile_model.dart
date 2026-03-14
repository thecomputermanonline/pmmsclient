class UserProfileModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? profileImageUrl;

  final String userType;
  final String city;
  final String budget;

  UserProfileModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.profileImageUrl,
    required this.userType,
    required this.city,
    required this.budget,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      userType: json['userType'] ?? 'Student',
      city: json['city'] ?? 'Port Louis',
      budget: json['budget'] ?? '',
      profileImageUrl: json['profileImageUrl'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "profileImageUrl": profileImageUrl,
    };
  }
}
