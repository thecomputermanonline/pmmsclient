class UpdateProfileRequest {
  final String firstName;
  final String lastName;
  final String? phone;

  UpdateProfileRequest({
    required this.firstName,
    required this.lastName,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    return {"firstName": firstName, "lastName": lastName, "phone": phone};
  }
}
