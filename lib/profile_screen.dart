// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
// import 'housing_screen.dart';

// class ProfileScreen extends StatefulWidget {
//   final String email;

//   const ProfileScreen({super.key, required this.email});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   String userType = "Student";
//   String school = "Middlesex University";

//   void updateProfile() async {
//     bool success = await ApiService.updateProfile(
//       widget.email,
//       userType,
//       userType == "Student" ? school : null,
//     );

//     if (success) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => HousingScreen(school: school)),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Update Profile")),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             DropdownButton<String>(
//               value: userType,
//               items: [
//                 "Student",
//                 "Non-Student",
//               ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//               onChanged: (value) => setState(() => userType = value!),
//             ),
//             if (userType == "Student")
//               DropdownButton<String>(
//                 value: school,
//                 items: ["Middlesex University", "Hamilton University"]
//                     .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                     .toList(),
//                 onChanged: (value) => setState(() => school = value!),
//               ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: updateProfile,
//               child: const Text("Continue"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
