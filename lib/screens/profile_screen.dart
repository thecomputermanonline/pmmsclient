import 'package:flutter/material.dart';
import 'package:realestate_app/models/user_profile.dart';
import 'property_listing_screen.dart';
import '../services/profile_service.dart';
import 'package:realestate_app/screens/property.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  String userType = "Student"; // default to Student

  /// Mauritius Cities
  final List<String> mauritiusCities = [
    "Port Louis",
    "Curepipe",
    "Quatre Bornes",
    "Vacoas",
    "Rose Hill",
    "Grand Baie",
    "Flic en Flac",
  ];

  late String selectedCity;

  /// Budget Options
  final List<String> budgetRanges = [
    "Rs 5,000 - Rs 10,000",
    "Rs 10,000 - Rs 15,000",
    "Rs 15,000 - Rs 20,000",
  ];

  late String selectedBudget;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final profile = await ProfileService.getProfile() ??
        await ProfileService.getCachedProfile();

    if (profile != null) {
      setState(() {
        firstNameController.text = profile.firstName;
        lastNameController.text = profile.lastName;
        emailController.text = profile.email;
        phoneController.text = profile.phone;
        userType = profile.userType;
        selectedCity = profile.city;
        selectedBudget = profile.budget;
      });
    }
  }

  ///
  Future<void> saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final profile = UserProfile(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(), // keep email in sync
      phone: phoneController.text.trim(),
      userType: userType,
      city: selectedCity,
      budget: selectedBudget,
    );

    final success = await ProfileService.updateProfile(profile);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Updated Successfully")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PropertyListingPage(
            city: profile.city,
            budget: profile.budget,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update profile")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              /// First Name
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  labelText: "First Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Enter first name" : null,
              ),
              const SizedBox(height: 20),

              /// Last Name
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  labelText: "Last Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Enter last name" : null,
              ),
              const SizedBox(height: 20),

              /// Email
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Email",
                  //// value: widget.email,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              /// Phone
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Enter phone number" : null,
              ),
              const SizedBox(height: 25),

              /// Student / Non-Student
              const Text("Are you a student?"),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: const Text("Student"),
                      value: "Student",
                      groupValue: userType,
                      onChanged: (value) {
                        setState(() {
                          userType = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text("Non-Student"),
                      value: "Non-Student",
                      groupValue: userType,
                      onChanged: (value) {
                        setState(() {
                          userType = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// City Dropdown
              DropdownButtonFormField(
                // initialValue: selectedCity,
                decoration: const InputDecoration(
                  labelText: "Preferred City",
                  border: OutlineInputBorder(),
                ),
                items: mauritiusCities
                    .map((city) => DropdownMenuItem(
                          value: city,
                          child: Text(city),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCity = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              /// Budget Dropdown
              DropdownButtonFormField(
                // initialValue: selectedBudget,
                decoration: const InputDecoration(
                  labelText: "Select Budget Range",
                  border: OutlineInputBorder(),
                ),
                items: budgetRanges
                    .map((budget) => DropdownMenuItem(
                          value: budget,
                          child: Text(budget),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBudget = value!;
                  });
                },
                validator: (value) =>
                    value == null ? "Please select budget range" : null,
              ),

              const SizedBox(height: 30),

              /// SAVE PROFILE
              ElevatedButton(
                onPressed: saveProfile,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text("Save Profile"),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
