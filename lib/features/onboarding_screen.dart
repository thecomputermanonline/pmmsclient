import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔥 STATIC BACKGROUND
          Positioned.fill(
            child: Image.asset(
              "assets/images/fullscreenbg.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          /// 🔥 DARK OVERLAY
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),

          /// 🔥 PAGEVIEW CONTENT
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => currentPage = index);
            },
            children: const [
              OnboardPage(
                icon: Icons.home,
                title: "Find Student Housing",
                description:
                    "Browse verified student accommodations near your campus.",
              ),
              OnboardPage(
                icon: Icons.verified_user,
                title: "Secure & Trusted",
                description: "Safe listings with verified landlords.",
              ),
              OnboardPage(
                icon: Icons.flash_on,
                title: "Easy Booking",
                description: "Book your new home in just a few taps.",
              ),
            ],
          ),

          /// 🔥 TOP RIGHT SKIP BUTTON
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: completeOnboarding,
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          /// 🔥 BOTTOM CONTROLS
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: Colors.white,
                  ),
                ),

                const SizedBox(height: 30),

                /// 🔥 BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (currentPage == 2) {
                        completeOnboarding();
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF35AFBA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      currentPage == 2 ? "Get Started" : "Next",
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const OnboardPage({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// 🔥 ICON WITH ANIMATION FEEL
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 800),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(
                  opacity: value,
                  child: child,
                ),
              );
            },
            child: Icon(icon, size: 120, color: Colors.white),
          ),

          const SizedBox(height: 50),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
