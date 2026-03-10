/*import 'package:flutter/material.dart';

class PropertyListingPage extends StatelessWidget {
  final List<Property> properties = [
    Property(
      id: '1',
      title: 'Beachfront Villa',
      location: 'North Shore',
      price: 1250000,
      imageUrl: 'https://via.placeholder.com/300x200?text=Beachfront+Villa',
      bedrooms: 4,
      bathrooms: 3,
      squareFeet: 3500,
    ),  
    Property(
      id: '2',
      title: 'Modern Cottage',
      location: 'Downtown',
      price: 650000,
      imageUrl: 'https://via.placeholder.com/300x200?text=Modern+Cottage',
      bedrooms: 3,
      bathrooms: 2,
      squareFeet: 2100,
    ),
    Property(
      id: '3',
      title: 'Luxury Estate',
      location: 'Hilltop',
      price: 2500000,
      imageUrl: 'https://via.placeholder.com/300x200?text=Luxury+Estate',
      bedrooms: 5,
      bathrooms: 4,
      squareFeet: 5200,
    ),
    Property(
      id: '4',
      name: 'Cozy Cabin',
      location: 'Countryside',
      price: 450000,
      imageUrl: 'https://via.placeholder.com/300x200?text=Cozy+Cabin',
      bedrooms: 2,
      bathrooms: 1,
      squareFeet: 1400,
    ),
  ];

  PropertyListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Island Homes'), elevation: 0),
      body: ListView.builder(
        itemCount: properties.length,
        itemBuilder: (context, index) {
          final property = properties[index];
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
                  property.name,
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
                  '\$${property.price.toStringAsFixed(0)}',
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
                  ],
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
*/
