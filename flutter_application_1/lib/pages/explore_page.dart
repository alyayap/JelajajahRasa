import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/place_models.dart';
import '../services/api_services.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String searchQuery = "";
  String sortType = "Default";

  late Future<List<Place>> placesFuture;

  @override
  void initState() {
    super.initState();
    placesFuture = ApiService.getPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.whiteSoft,
        title: const Text(
          "Jelajahi Kuliner",
          style: TextStyle(
            color: AppColors.brownDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.brownDark),
      ),
      body: Column(
        children: [
          // 🔍 SEARCH + FILTER
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Cari tempat...",
                      prefixIcon:
                          const Icon(Icons.search, color: AppColors.brownDark),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: AppColors.whiteSoft,
                    ),
                    onChanged: (v) => setState(() => searchQuery = v),
                  ),
                ),
                const SizedBox(width: 8),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.filter_list,
                      color: AppColors.brownDark),
                  onSelected: (v) => setState(() => sortType = v),
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: "Default", child: Text("Default")),
                    PopupMenuItem(value: "Termurah", child: Text("Termurah")),
                  ],
                ),
              ],
            ),
          ),

          // 📦 DATA FROM API
          Expanded(
            child: FutureBuilder<List<Place>>(
              future: placesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                }

                List<Place> places = snapshot.data!;

                // 🔎 SEARCH
                List<Place> filteredPlaces = places.where((p) {
                  return p.name
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase());
                }).toList();

                // 🔃 SORT
                if (sortType == "Termurah") {
                  filteredPlaces
                      .sort((a, b) => a.avgPrice.compareTo(b.avgPrice));
                }

                if (filteredPlaces.isEmpty) {
                  return const Center(
                    child: Text(
                      "Tempat tidak ditemukan.",
                      style: TextStyle(color: AppColors.brownDark),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: filteredPlaces.length,
                  itemBuilder: (context, idx) {
                    final p = filteredPlaces[idx];

                    return GestureDetector(
                      onTap: () => _openDetail(p),
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        color: AppColors.whiteSoft,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(14)),
                              child: Image.network(
                                p.imageUrl,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) => Container(
                                  height: 180,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.broken_image,
                                      size: 60,
                                      color: AppColors.brownDark),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.brownDark,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${p.rating}",
                                        style: const TextStyle(
                                            color: Colors.black54),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 📄 DETAIL POPUP
  void _openDetail(Place place) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(place.name),
        content: Text(
          "Kategori: ${place.category}\nRating: ${place.rating}\nHarga rata-rata: ${place.avgPrice}",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }
}
