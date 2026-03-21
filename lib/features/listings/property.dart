import 'package:flutter/material.dart';
import '../../models/property_model.dart';

class PropertyListingPage extends StatelessWidget {
  final String city;
  final String budget;

  const PropertyListingPage({
    super.key,
    required this.city,
    required this.budget,
  });

  @override
  Widget build(BuildContext context) {
    final List<Property> allProperties = [
      Property(
        id: "1",
        title: "Student Apartment Near Campus",
        description: "Modern student apartment located 5 minutes from campus.",
        location: "Port Louis",
        price: 8500,
        images: [
          "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2",
        ],
        imageUrl: "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2",
        squareFeet: 3500,
        bedrooms: 2,
        bathrooms: 1,
        isStudentOnly: true,
        wifiIncluded: true,
        electricityIncluded: true,
        waterIncluded: true,
        furnished: true,
        landlordName: "Mr. Raman",
        rating: 4.5,
      ),
      Property(
        id: "2",
        title: "Shared Room in Curepipe",
        description: "Affordable shared room perfect for students.",
        location: "Curepipe",
        price: 6000,
        images: [
          "https://images.unsplash.com/photo-1507089947368-19c1da9775ae",
        ],
        imageUrl:
            "https://images.unsplash.com/photo-1507089947368-19c1da9775ae",
        bedrooms: 1,
        bathrooms: 1,
        isStudentOnly: true,
        wifiIncluded: true,
        electricityIncluded: false,
        waterIncluded: true,
        furnished: true,
        landlordName: "Mrs. Devi",
        rating: 4.2,
        squareFeet: 2500,
      ),
      Property(
        id: "3",
        title: "Student Room in Quatre Bornes",
        description: "Cozy furnished room near metro station.",
        location: "Quatre Bornes",
        price: 7500,
        images: [
          "https://images.unsplash.com/photo-1493809842364-78817add7ffb",
        ],
        imageUrl:
            "https://images.unsplash.com/photo-1493809842364-78817add7ffb",
        bedrooms: 1,
        bathrooms: 1,
        isStudentOnly: true,
        wifiIncluded: true,
        electricityIncluded: true,
        waterIncluded: true,
        furnished: true,
        landlordName: "Mr. Jean",
        rating: 4.6,
        squareFeet: 4500,
      ),
      Property(
        id: "4",
        title: "Student Studio in Vacoas",
        description: "Affordable studio perfect for university students.",
        location: "Vacoas",
        price: 9000,
        images: [
          "https://images.unsplash.com/photo-1572120360610-d971b9d7767c",
        ],
        imageUrl:
            "https://images.unsplash.com/photo-1572120360610-d971b9d7767c",
        bedrooms: 1,
        bathrooms: 1,
        isStudentOnly: true,
        wifiIncluded: true,
        electricityIncluded: false,
        waterIncluded: true,
        furnished: true,
        landlordName: "Mrs. Pillay",
        rating: 4.3,
        squareFeet: 4000,
      ),
      Property(
        id: "5",
        title: "Student Room in Rose Hill",
        description: "Close to bus station and shopping areas.",
        location: "Rose Hill",
        price: 7000,
        images: [
          "https://images.unsplash.com/photo-1484154218962-a197022b5858",
        ],
        imageUrl:
            "https://images.unsplash.com/photo-1484154218962-a197022b5858",
        bedrooms: 1,
        bathrooms: 1,
        isStudentOnly: true,
        wifiIncluded: true,
        electricityIncluded: true,
        waterIncluded: true,
        furnished: true,
        landlordName: "Mr. Ali",
        rating: 4.1,
        squareFeet: 3500,
      ),
      Property(
        id: "6",
        title: "Student Apartment in Grand Baie",
        description: "Modern apartment near beach and amenities.",
        location: "Grand Baie",
        price: 10000,
        images: [
          "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688",
        ],
        imageUrl: 'https://via.placeholder.com/300x200?text=Modern+Cottage',
        bedrooms: 3,
        bathrooms: 2,
        squareFeet: 2100,
        isStudentOnly: true,
        wifiIncluded: true,
        electricityIncluded: true,
        waterIncluded: true,
        furnished: true,
        landlordName: "Mr. Laurent",
        rating: 4.8,
      ),
      Property(
        id: "7",
        title: "Student Studio in Flic en Flac",
        description: "Sea view studio with fast WiFi included.",
        location: "Flic en Flac",
        price: 9500,
        images: [
          "https://images.unsplash.com/photo-1512917774080-9991f1c4c750",
        ],
        imageUrl:
            "https://images.unsplash.com/photo-1512917774080-9991f1c4c750",
        bedrooms: 1,
        bathrooms: 1,
        isStudentOnly: true,
        wifiIncluded: true,
        electricityIncluded: true,
        waterIncluded: true,
        furnished: true,
        landlordName: "Mrs. Marie",
        rating: 4.7,
        squareFeet: 5000,
      ),
    ];

    ///  FILTER LOGIC
    final double? selectedBudget = double.tryParse(budget);

    final filteredProperties = allProperties.where((property) {
      final matchesCity = property.location.toLowerCase() == city.toLowerCase();

      final matchesBudget =
          selectedBudget == null || property.price <= selectedBudget;

      final matchesStudent = property.isStudentOnly;

      return matchesCity && matchesBudget && matchesStudent;
    }).toList();

    ///  SORT BY PRICE (LOW → HIGH)

    return Scaffold(
      //appBar: AppBar(title: const Text('Island Homes'), elevation: 0),
      body: filteredProperties.isEmpty
          ? ListView.builder(
              itemCount: allProperties.length,
              itemBuilder: (context, index) {
                final property = allProperties[index];
                return PropertyCard(property: property);
              },
            )
          : ListView.builder(
              itemCount: filteredProperties.length,
              itemBuilder: (context, index) {
                final property = filteredProperties[index];
                return PropertyCard(property: property);
              },
            ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final Property property;

  const PropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            property.imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  property.location,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  'Rs ${property.price.toStringAsFixed(0)} / month',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _PropertyDetail(
                      icon: Icons.bed,
                      label: '${property.bedrooms} Beds',
                    ),
                    _PropertyDetail(
                      icon: Icons.bathroom,
                      label: '${property.bathrooms} Baths',
                    ),
                    _PropertyDetail(
                      icon: Icons.square_foot,
                      label: '${property.squareFeet.toStringAsFixed(0)} sqft',
                    ),
                    _PropertyDetail(
                      icon: Icons.electric_bolt,
                      label: '${property.electricityIncluded}',
                    ),
                    _PropertyDetail(
                      icon: Icons.wifi,
                      label: '${property.wifiIncluded}',
                    ),
                    _PropertyDetail(
                      icon: Icons.school,
                      label: '${property.isStudentOnly}',
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text("Book Viewing"),
                ),
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
        ],
      ),
    );
  }
}

class _PropertyDetail extends StatelessWidget {
  final IconData icon;
  final String label;

  const _PropertyDetail({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
