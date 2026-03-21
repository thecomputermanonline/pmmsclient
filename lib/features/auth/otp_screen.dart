// import 'package:flutter/material.dart';
// import '../core/services/api_service.dart';
// import 'profile_screen.dart';

// class OtpScreen extends StatefulWidget {
//   final String email;

//   const OtpScreen({super.key, required this.email});

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   final TextEditingController otpController = TextEditingController();

//   bool isVerifying = false;
//   bool isResending = false;

//   Future<void> verifyOtp() async {
//     String otp = otpController.text.trim();

//     if (otp.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter the OTP")),
//       );
//       return;
//     }

//     if (otp.length != 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("OTP must be 6 digits")),
//       );
//       return;
//     }

//     setState(() {
//       isVerifying = true;
//     });

//     try {
//       bool success = await ApiService.verifyOtp(widget.email, otp);

//       if (!mounted) return;

//       if (success) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("OTP verified successfully")),
//         );
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => ProfileScreen()),
//           (route) => false,
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Invalid OTP")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Verification failed: $e")),
//       );
//     } finally {
//       if (mounted) {
//         setState(() {
//           isVerifying = false;
//         });
//       }
//     }
//   }

//   Future<void> resendOtp() async {
//     setState(() {
//       isResending = true;
//     });

//     try {
//       await ApiService.sendOtp(widget.email);

//       if (!mounted) return;

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("OTP resent successfully")),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Failed to resend OTP: $e")),
//       );
//     } finally {
//       if (mounted) {
//         setState(() {
//           isResending = false;
//         });
//       }
//     }
//   }

//   @override
//   void dispose() {
//     otpController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Verify OTP"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 10),
//             Text(
//               "OTP sent to ${widget.email}",
//               style: const TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//             const SizedBox(height: 30),
//             TextField(
//               controller: otpController,
//               keyboardType: TextInputType.number,
//               maxLength: 6,
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
//             const SizedBox(height: 20),
//             Center(
//               child: TextButton(
//                 onPressed: isResending ? null : resendOtp,
//                 child: isResending
//                     ? const CircularProgressIndicator()
//                     : const Text("Resend OTP"),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../core/services/api_service.dart';
import '../profile/profile_screen.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  bool isVerifying = false;
  bool isResending = false;

  Future<void> verifyOtp() async {
    String otp = otpController.text.trim();

    if (otp.isEmpty) {
      showMessage("Please enter the OTP");
      return;
    }

    if (otp.length != 6) {
      showMessage("OTP must be 6 digits");
      return;
    }

    setState(() => isVerifying = true);

    try {
      bool success = await ApiService.verifyOtp(widget.email, otp);

      if (!mounted) return;

      if (!success) {
        showMessage("OTP verified successfully");

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
          (route) => false,
        );
      } else {
        showMessage("Invalid OTP");
      }
    } catch (e) {
      showMessage("Verification failed: $e");
    } finally {
      if (mounted) setState(() => isVerifying = false);
    }
  }

  Future<void> resendOtp() async {
    setState(() => isResending = true);

    try {
      await ApiService.sendOtp(widget.email);

      if (!mounted) return;

      showMessage("OTP resent successfully");
    } catch (e) {
      showMessage("Failed to resend OTP: $e");
    } finally {
      if (mounted) setState(() => isResending = false);
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔥 BACKGROUND (same as login/onboarding)
          Positioned.fill(
            child: Image.asset(
              "assets/images/fullscreenbg.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          /// 🔥 DARK OVERLAY
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.6),
            ),
          ),

          /// 🔥 CONTENT
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  /// 🔥 ICON
                  const Icon(Icons.lock_outline,
                      size: 100, color: Colors.white),

                  const SizedBox(height: 20),

                  /// 🔥 TITLE
                  const Text(
                    "Verify Code",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// 🔥 SUBTEXT
                  Text(
                    "Enter the 6-digit code sent to\n${widget.email}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 40),

                  /// 🔥 OTP FIELD
                  TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      letterSpacing: 8,
                    ),
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "------",
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// 🔥 VERIFY BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: isVerifying ? null : verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF35AFBA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: isVerifying
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Verify",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 🔥 RESEND
                  TextButton(
                    onPressed: isResending ? null : resendOtp,
                    child: isResending
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Resend Code",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),

                  const SizedBox(height: 10),

                  /// 🔥 EXTRA INFO
                  const Text(
                    "Didn’t receive the code?",
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
