/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import 'favorites_screen.dart';
import 'property_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> properties = [];
  List<dynamic> favoriteList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProperties();
    loadFavorites();
  }

  // ==========================
  // LOAD PROPERTIES FROM API
  // ==========================
  Future<void> loadProperties() async {
    try {
      final data = await ApiService.fetchProperties();
      setState(() {
        properties = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load properties")),
      );
    }
  }

  // ==========================
  // LOAD FAVORITES (LOCAL)
  // ==========================
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString("favorites");

    if (data != null) {
      setState(() {
        favoriteList = jsonDecode(data);
      });
    }
  }

  // ==========================
  // SAVE FAVORITES (LOCAL)
  // ==========================
  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(favoriteList);
    await prefs.setString("favorites", encoded);
  }

  // ==========================
  // TOGGLE FAVORITE
  // ==========================
  void toggleFavorite(dynamic property) {
    setState(() {
      if (favoriteList.any((item) => item["id"] == property["id"])) {
        favoriteList.removeWhere((item) => item["id"] == property["id"]);
      } else {
        favoriteList.add(property);
      }
    });

    saveFavorites();
  }

  bool isFavorite(dynamic property) {
    return favoriteList.any((item) => item["id"] == property["id"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Housing"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesScreen(
                    favoriteProperties: favoriteList,
                    onRemove: (property) {
                      setState(() {
                        favoriteList.removeWhere(
                          (item) => item["id"] == property["id"],
                        );
                      });
                      saveFavorites();
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadProperties,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: properties.length,
                itemBuilder: (context, index) {
                  final property = properties[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(bottom: 15),
                    child: ListTile(
                      leading: const Icon(Icons.home),
                      title: Text(property["title"] ?? "Property"),
                      subtitle: Text("₦${property["price"] ?? "0"}"),
                      trailing: IconButton(
                        icon: Icon(
                          isFavorite(property)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite(property)
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: () => toggleFavorite(property),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PropertyDetailsScreen(property: property),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}

*/

/*

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import 'favorites_screen.dart';
import 'property_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> properties = [];
  List<dynamic> favoriteList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProperties();
    loadFavorites();
  }

  // ==========================
  // LOAD PROPERTIES FROM API
  // ==========================
  Future<void> loadProperties() async {
    try {
      final data = await ApiService.fetchProperties();
      setState(() {
        properties = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load properties")),
      );
    }
  }

  // ==========================
  // LOAD FAVORITES
  // ==========================
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString("favorites");
    if (data != null) {
      setState(() {
        favoriteList = jsonDecode(data);
      });
    }
  }

  // ==========================
  // SAVE FAVORITES
  // ==========================
  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("favorites", jsonEncode(favoriteList));
  }

  // ==========================
  // TOGGLE FAVORITE
  // ==========================
  void toggleFavorite(dynamic property) {
    setState(() {
      if (favoriteList.any((item) => item["id"] == property["id"])) {
        favoriteList.removeWhere((item) => item["id"] == property["id"]);
      } else {
        favoriteList.add(property);
      }
    });
    saveFavorites();
  }

  bool isFavorite(dynamic property) {
    return favoriteList.any((item) => item["id"] == property["id"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Housing"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesScreen(
                    favoriteProperties: favoriteList,
                    onRemove: (property) {
                      setState(() {
                        favoriteList.removeWhere(
                          (item) => item["id"] == property["id"],
                        );
                      });
                      saveFavorites();
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadProperties,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: properties.length,
                itemBuilder: (context, index) {
                  final property = properties[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PropertyDetailsScreen(property: property),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image from API
                          Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  property["imageUrl"] ??
                                      "https://via.placeholder.com/400",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title
                                Text(
                                  property["title"] ?? "Property Title",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                // Price
                                Text(
                                  "₦${property["price"] ?? "0"}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                // Short description
                                Text(
                                  property["description"] ??
                                      "No description available",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                const SizedBox(height: 8),

                                // Favorite button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        isFavorite(property)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFavorite(property)
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                      onPressed: () => toggleFavorite(property),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

*/

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/api_service.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> properties = [];
  List<dynamic> favoriteList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProperties();
    loadFavorites();
  }

  // Load properties from API
  Future<void> loadProperties() async {
    try {
      final data = await ApiService.fetchProperties();
      setState(() {
        properties = data!;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load properties")),
      );
    }
  }

  // Load favorites from SharedPreferences
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString("favorites");
    if (data != null) {
      setState(() {
        favoriteList = jsonDecode(data);
      });
    }
  }

  // Save favorites
  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("favorites", jsonEncode(favoriteList));
  }

  // Toggle favorite
  void toggleFavorite(dynamic property) {
    setState(() {
      if (favoriteList.any((item) => item["id"] == property["id"])) {
        favoriteList.removeWhere((item) => item["id"] == property["id"]);
      } else {
        favoriteList.add(property);
      }
    });
    saveFavorites();
  }

  bool isFavorite(dynamic property) {
    return favoriteList.any((item) => item["id"] == property["id"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Housing"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesScreen(
                    favoriteProperties: favoriteList,
                    onRemove: (property) {
                      setState(() {
                        favoriteList.removeWhere(
                          (item) => item["id"] == property["id"],
                        );
                      });
                      saveFavorites();
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadProperties,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: properties.length,
                itemBuilder: (context, index) {
                  final property = properties[index];

                  return GestureDetector(
                    onTap: () {},
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image
                          Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  property["imageUrl"] ??
                                      "https://via.placeholder.com/400",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  property["title"] ?? "Property Title",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "₦${property["price"] ?? "0"}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  property["description"] ??
                                      "No description available",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        isFavorite(property)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFavorite(property)
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                      onPressed: () => toggleFavorite(property),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
