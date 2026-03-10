// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
// import '../services/location_service.dart';

// class HousingScreen extends StatefulWidget {
//   final String school;

//   const HousingScreen({super.key, required this.school});

//   @override
//   State<HousingScreen> createState() => _HousingScreenState();
// }

// class _HousingScreenState extends State<HousingScreen> {
//   List<Map<String, dynamic>> houses = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     loadHouses();
//   }

//   Future<void> loadHouses() async {
//     final properties = await ApiService.fetchProperties();

//     final filtered = LocationService.filterNearbyHouses(
//       widget.school,
//       List<Map<String, dynamic>>.from(properties),
//     );

//     setState(() {
//       houses = filtered;
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Available Housing")),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: houses.length,
//               itemBuilder: (context, index) {
//                 return ListTile(title: Text(houses[index]["name"]));
//               },
//             ),
//     );
//   }
// }
