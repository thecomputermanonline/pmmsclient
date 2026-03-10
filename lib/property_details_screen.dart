import 'package:flutter/material.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final dynamic property;

  const PropertyDetailsScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(property["title"] ?? "Property Details"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Property Image / Placeholder
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.home, size: 80, color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),

              // Title
              Text(
                property["title"] ?? "Property Title",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // Price
              Text(
                "₦${property["price"] ?? "0"}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 20),

              // Description Section
              const Text(
                "Description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                property["description"] ??
                    "No description available for this property.",
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 20),

              // Location Section
              const Text(
                "Location",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                property["location"] ?? "No location info",
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 30),

              // Contact / Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.phone),
                  label: const Text("Contact Owner"),
                  onPressed: () {
                    // TODO: Connect to phone/email backend
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Contact feature coming soon!"),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
