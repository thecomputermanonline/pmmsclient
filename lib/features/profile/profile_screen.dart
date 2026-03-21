import 'package:flutter/material.dart';
import '../../core/services/profile_service.dart';
import '../../models/user_profile_model.dart';
import '../navigation/main_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  String userType = "Student";
  final List<String> schools = [
    "University of Mauritius",
    "University of Technology Mauritius",
    "Open University",
    "Mahatma Gandhi Institute",
    "Other",
  ];

  String selectedSchool = "";
  final List<String> mauritiusCities = [
    "Port Louis",
    "Curepipe",
    "Quatre Bornes",
    "Vacoas",
    "Rose Hill",
    "Grand Baie",
    "Flic en Flac",
  ];
  List<String> selectedCities = [];

  final List<String> budgetRanges = [
    "Rs 5,000 - Rs 10,000",
    "Rs 10,000 - Rs 15,000",
    "Rs 15,000 - Rs 20,000",
  ];
  String selectedBudget = "";

  final List<String> propertyTypes = [
    "Apartment",
    "Studio",
    "Shared Room",
    "Villa",
  ];
  String selectedPropertyType = "";

  late final AnimationController _animationController;
  late final List<Animation<Offset>> _slideAnimations;
  late final List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _initAnimations();
    _animationController.forward();
  }

  void _initAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _slideAnimations = List.generate(
      6,
      (index) => Tween<Offset>(
        begin: const Offset(0, 0.2),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve:
              Interval(0.1 * index, 0.6 + 0.1 * index, curve: Curves.easeOut),
        ),
      ),
    );

    _fadeAnimations = List.generate(
      6,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.1 * index, 0.6 + 0.1 * index, curve: Curves.easeIn),
        ),
      ),
    );
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
        selectedCities = [profile.city];
        selectedBudget = profile.budget;
        selectedPropertyType = profile.propertyType ?? "";
      });
    }
  }

  Future<void> saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final profile = UserProfileModel(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      userType: userType,
      city: selectedCities.isNotEmpty ? selectedCities.first : "",
      budget: selectedBudget,
      propertyType: selectedPropertyType,
      school: userType == "Student" ? selectedSchool : null,
    );

    final success = await ProfileService.updateProfile(profile);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Updated Successfully")),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => MainScreen()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update profile")),
      );
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  /// 🔹 STAGGERED CHIP TOGGLE
  void toggleChipSelection(List<String> selectionList, String value) async {
    if (selectionList.contains(value)) {
      setState(() => selectionList.remove(value));
    } else {
      setState(() => selectionList.add("")); // placeholder
      await Future.delayed(const Duration(milliseconds: 50));
      if (mounted) {
        setState(() => selectionList[selectionList.indexOf("")] = value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/fullscreenbg.jpeg",
                fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.6)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // ICON + TITLE
                    SlideTransition(
                      position: _slideAnimations[0],
                      child: FadeTransition(
                        opacity: _fadeAnimations[0],
                        child: Column(
                          children: const [
                            Icon(Icons.person_outline,
                                size: 100, color: Colors.white),
                            SizedBox(height: 2),
                            Text(
                              "Complete Your Profile",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 1),
                            Text(
                              "Let us know you and what you are looking for",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white70),
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),

                    // PERSONAL INFO
                    SlideTransition(
                      position: _slideAnimations[1],
                      child: FadeTransition(
                        opacity: _fadeAnimations[1],
                        child: buildCard(
                          children: [
                            buildTextField(firstNameController, "First Name"),
                            buildTextField(lastNameController, "Last Name"),
                            buildTextField(emailController, "Email",
                                readOnly: true),
                            buildTextField(phoneController, "Phone"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // USER TYPE
                    SlideTransition(
                      position: _slideAnimations[5],
                      child: FadeTransition(
                        opacity: _fadeAnimations[5],
                        child: Column(
                          children: [
                            buildCard(
                              active: userType.isNotEmpty,
                              children: [
                                const Text("Who are You",
                                    style: TextStyle(color: Colors.white)),
                                Wrap(
                                  spacing: 10,
                                  children: ["Student", "Tourist", "Expat"]
                                      .map((type) {
                                    final isSelected = userType == type;
                                    return AnimatedScale(
                                      scale: isSelected ? 1.05 : 1.0,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                      child: ChoiceChip(
                                        label: Text(type),
                                        selected: isSelected,
                                        onSelected: (_) {
                                          setState(() => userType = type);
                                        },
                                        selectedColor: const Color(0xFF35AFBA),
                                        backgroundColor: Colors.white12,
                                        labelStyle: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Color(0xFF35AFBA),
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    if (userType == "Student")
                      SlideTransition(
                        position: _slideAnimations[
                            3], // reuse or create a new animation
                        child: FadeTransition(
                          opacity: _fadeAnimations[3],
                          child: buildCard(
                            active: selectedSchool.isNotEmpty,
                            children: [
                              const Text("Select Your School",
                                  style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  value: selectedSchool.isNotEmpty
                                      ? selectedSchool
                                      : null,
                                  dropdownColor: Colors.black87,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                  items: schools.map((school) {
                                    return DropdownMenuItem(
                                      value: school,
                                      child: Text(school,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedSchool = value!;
                                    });
                                  },
                                  validator: (value) =>
                                      value == null || value.isEmpty
                                          ? "Please select a school"
                                          : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    // PREFERRED CITIES
                    SlideTransition(
                      position: _slideAnimations[3],
                      child: FadeTransition(
                        opacity: _fadeAnimations[3],
                        child: buildCard(
                          active: selectedCities.isNotEmpty,
                          children: [
                            const Text("Preferred Cities",
                                style: TextStyle(color: Colors.white)),
                            Wrap(
                              spacing: 10,
                              children: mauritiusCities.map((city) {
                                final isSelected =
                                    selectedCities.contains(city);
                                return AnimatedScale(
                                  scale: isSelected ? 1.05 : 1.0,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut,
                                  child: ChoiceChip(
                                    label: Text(city),
                                    selected: isSelected,
                                    onSelected: (_) => toggleChipSelection(
                                        selectedCities, city),
                                    selectedColor: const Color(0xFF35AFBA),
                                    backgroundColor: Colors.white12,
                                    labelStyle: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Color(0xFF35AFBA),
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // PROPERTY TYPE
                    SlideTransition(
                      position: _slideAnimations[4],
                      child: FadeTransition(
                        opacity: _fadeAnimations[4],
                        child: buildCard(
                          active: selectedPropertyType.isNotEmpty,
                          children: [
                            const Text("Property Type",
                                style: TextStyle(color: Colors.white)),
                            Wrap(
                              spacing: 10,
                              children: propertyTypes.map((type) {
                                final isSelected = selectedPropertyType == type;
                                return AnimatedScale(
                                  scale: isSelected ? 1.05 : 1.0,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut,
                                  child: ChoiceChip(
                                    label: Text(type),
                                    selected: isSelected,
                                    onSelected: (_) {
                                      setState(
                                          () => selectedPropertyType = type);
                                    },
                                    selectedColor: const Color(0xFF35AFBA),
                                    backgroundColor: Colors.white12,
                                    labelStyle: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Color(0xFF35AFBA),
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // BUDGET RANGE + SAVE BUTTON
                    SlideTransition(
                      position: _slideAnimations[5],
                      child: FadeTransition(
                        opacity: _fadeAnimations[5],
                        child: Column(
                          children: [
                            buildCard(
                              active: selectedBudget.isNotEmpty,
                              children: [
                                const Text("Budget Range",
                                    style: TextStyle(color: Colors.white)),
                                Wrap(
                                  spacing: 10,
                                  children: budgetRanges.map((budget) {
                                    final isSelected = selectedBudget == budget;
                                    return AnimatedScale(
                                      scale: isSelected ? 1.05 : 1.0,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                      child: ChoiceChip(
                                        label: Text(budget),
                                        selected: isSelected,
                                        onSelected: (_) {
                                          setState(
                                              () => selectedBudget = budget);
                                        },
                                        selectedColor: const Color(0xFF35AFBA),
                                        backgroundColor: Colors.white12,
                                        labelStyle: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Color(0xFF35AFBA),
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                onPressed: saveProfile,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF35AFBA),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text(
                                  "Continue",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard({required List<Widget> children, bool active = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: active
            ? Colors.white.withOpacity(0.15)
            : Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(15),
        boxShadow: active
            ? [
                BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5))
              ]
            : [],
      ),
      child: Column(children: children),
    );
  }

  Widget buildTextField(TextEditingController controller, String label,
      {bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? "Enter $label" : null,
      ),
    );
  }
}
