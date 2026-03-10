class UserProfile {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String userType;
  final String city;
  final String budget;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.userType,
    required this.city,
    required this.budget,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      userType: json['userType'] ?? 'Student',
      city: json['city'] ?? 'Port Louis',
      budget: json['budget'] ?? '',
    );
  }
}
