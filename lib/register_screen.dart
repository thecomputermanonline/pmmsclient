// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
// import 'otp_screen.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final emailController = TextEditingController();
//   bool isLoading = false;

//   void sendOTP() async {
//     setState(() => isLoading = true);
//     //comment line 19 out to mock success
//     bool success = await ApiService.sendOtp(emailController.text.trim());
//     //bool success = true; //mocking success for testing

//     setState(() => isLoading = false);

//     if (success) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => OtpScreen(email: emailController.text.trim()),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Failed to send OTP")));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Register")),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: "Enter Email"),
//             ),
//             const SizedBox(height: 20),
//             isLoading
//                 ? const CircularProgressIndicator()
//                 : ElevatedButton(
//                     onPressed: sendOTP,
//                     child: const Text("Send OTP"),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// //IGNORE OTP
// // import 'package:flutter/material.dart';
// // import '../services/api_service.dart';
// // import 'profile_screen.dart';

// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({super.key});

// //   @override
// //   State<LoginScreen> createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends State<LoginScreen> {
// //   final emailController = TextEditingController();
// //   final _formKey = GlobalKey<FormState>();
// //   bool isLoading = false;

// //   // ✅ Email validation function
// //   bool isValidEmail(String email) {
// //     return RegExp(
// //       r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
// //     ).hasMatch(email);
// //   }

// //   Future<void> sendOtp() async {
// //     if (!_formKey.currentState!.validate()) {
// //       return; // Stop if email is invalid
// //     }

// //     String email = emailController.text.trim();

// //     setState(() => isLoading = true);

// //     try {
// //       // ✅ Call API (still happens)
// //       await ApiService.sendOtp(email);
// //     } catch (e) {
// //       // ✅ Ignore API errors
// //       debugPrint("OTP Error: $e");
// //     } finally {
// //       setState(() => isLoading = false);
// //     }

// //     // ✅ ALWAYS navigate to Profile Screen
// //     Navigator.pushReplacement(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => ProfileScreen(email: email),
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     emailController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Email Login")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(20),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             children: [
// //               TextFormField(
// //                 controller: emailController,
// //                 keyboardType: TextInputType.emailAddress,
// //                 decoration: const InputDecoration(
// //                   labelText: "Enter Email",
// //                   hintText: "username@example.com", // ✅ Shows format
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return "Please enter your email";
// //                   }
// //                   if (!isValidEmail(value.trim())) {
// //                     return "Email must be in the format username@example.com";
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               const SizedBox(height: 20),
// //               ElevatedButton(
// //                 onPressed: isLoading ? null : sendOtp,
// //                 style: ElevatedButton.styleFrom(
// //                   minimumSize: const Size.fromHeight(50),
// //                 ),
// //                 child: isLoading
// //                     ? const SizedBox(
// //                         height: 22,
// //                         width: 22,
// //                         child: CircularProgressIndicator(
// //                           strokeWidth: 2,
// //                           color: Colors.white,
// //                         ),
// //                       )
// //                     : const Text("Continue"),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }




// // TO SEND FORGET TO SEND OTP

// /*
// import 'package:flutter/material.dart';
// //import '../services/api_service.dart';

// class OtpScreen extends StatefulWidget {
//   final String email; // Receive email from LoginScreen
//   const OtpScreen({super.key, required this.email});

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   final otpController = TextEditingController();
//   bool isVerifying = false;

//   Future<void> verifyOtp() async {
//     String otp = otpController.text.trim();

//     if (otp.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter the OTP")),
//       );
//       return;
//     }

//     setState(() => isVerifying = true);

//     try {
//       // Call backend API to verify OTP
//       // Example: await ApiService.verifyOtp(widget.email, otp);
//       await Future.delayed(const Duration(seconds: 1)); // mock delay

//       // For now, just show success
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("OTP verified successfully!")),
//       );

//       // Navigate to Profile Page and remove previous screens
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const ProfileScreen(),
//       ),
//     );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error verifying OTP: $e")),
//       );
//     } finally {
//       setState(() => isVerifying = false);
//     }
//   }
// @override
//   void dispose() {
//     otpController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Enter OTP")),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Text(
//               "OTP sent to ${widget.email}",
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: otpController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: "Enter OTP",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: isVerifying ? null : verifyOtp,
//               style: ElevatedButton.styleFrom(
//                   minimumSize: const Size.fromHeight(50)),
//               child: isVerifying
//                   ? const CircularProgressIndicator(color: Colors.white)
//                   : const Text("Verify OTP"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// } 
// */

// //TO ALLOW TO NAVIGATE TO NEXT PAGE
// import 'package:flutter/material.dart';
// import 'profile_screen.dart'; // Make sure this file exists

// class OtpScreen extends StatefulWidget {
//   final String email;

//   const OtpScreen({super.key, required this.email});

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   final otpController = TextEditingController();
//   bool isVerifying = false;

//   Future<void> verifyOtp() async {
//     String otp = otpController.text.trim();

//     if (otp.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter the OTP")),
//       );
//       return;
//     }

//     setState(() => isVerifying = true);

//     // Simulate short delay
//     await Future.delayed(const Duration(seconds: 1));

//     if (!mounted) return;

//     setState(() => isVerifying = false);

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("OTP Verified Successfully")),
//     );

//     // Navigate to Profile Page and remove previous screens
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const ProfileScreen(),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     otpController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Enter OTP")),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "OTP sent to ${widget.email}",
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: otpController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: "Enter OTP",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 25),
//             ElevatedButton(
//               onPressed: isVerifying ? null : verifyOtp,
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size.fromHeight(50),
//               ),
//               child: isVerifying
//                   ? const CircularProgressIndicator(color: Colors.white)
//                   : const Text("Verify OTP"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }// ends here


// /*