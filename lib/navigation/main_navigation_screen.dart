// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:realestate_app/features/property.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../features/favorites_screen.dart';
// import '../settings_screen.dart';

// class MainNavigationScreen extends StatefulWidget {
//   const MainNavigationScreen({super.key});

//   @override
//   State<MainNavigationScreen> createState() => _MainNavigationScreenState();
// }

// class _MainNavigationScreenState extends State<MainNavigationScreen> {
//   int _selectedIndex = 0;

//   List<dynamic> favoriteList = [];
//   final screens = [
//     HomeScreen(),
//     ListingsScreen(),
//     BookingsScreen(),
//     MessagesScreen(),
//     ProfileScreen(),
//   ];
//   @override
//   void initState() {
//     super.initState();
//     loadFavorites();
//   }

//   // =============================
//   // LOAD FAVORITES FROM STORAGE
//   // =============================
//   Future<void> loadFavorites() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? data = prefs.getString("favorites");

//     if (data != null) {
//       setState(() {
//         favoriteList = jsonDecode(data);
//       });
//     }
//   }

//   // =============================
//   // SAVE FAVORITES
//   // =============================
//   Future<void> saveFavorites() async {
//     final prefs = await SharedPreferences.getInstance();
//     final encoded = jsonEncode(favoriteList);
//     await prefs.setString("favorites", encoded);
//   }

//   void removeFavorite(dynamic property) {
//     setState(() {
//       favoriteList.removeWhere((item) => item["id"] == property["id"]);
//     });
//     saveFavorites();
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   String city = '';

//   String budget = '';
//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> screens = [
//       PropertyListingPage(
//           city: city, budget: budget), // Home manages its own favorites
//       FavoritesScreen(
//         favoriteProperties: favoriteList,
//         onRemove: removeFavorite,
//       ),
//       const SettingsScreen(),
//     ];

//     return Scaffold(
//       body: screens[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: "Favorites",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: "Settings",
//           ),
//         ],
//       ),
//     );
//   }
// }
