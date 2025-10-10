import 'package:flutter/material.dart';
import '../theme.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String searchQuery = "";
  String sortType = "Default";

  final List<Map<String, dynamic>> places = [
    {
      "name": "Warung Nusantara",
      "image":
          "https://images.unsplash.com/photo-1600891964599-f61ba0e24092?w=700",
      "menu": [
        {"name": "Nasi Goreng Spesial", "price": 25000},
        {"name": "Ayam Bakar", "price": 30000}
      ],
      "rating": 4.8,
      "distance": 1.2,
      "desc": "Rasakan cita rasa nusantara dengan bumbu tradisional khas Indonesia."
    },
    {
      "name": "Cafe Santai",
      "image":
          "https://images.unsplash.com/photo-1551782450-a2132b4ba21d?w=700",
      "menu": [
        {"name": "Cappuccino", "price": 18000},
        {"name": "Croissant", "price": 15000}
      ],
      "rating": 4.5,
      "distance": 0.9,
      "desc":
          "Tempat nongkrong kekinian dengan aroma kopi yang menggoda dan suasana cozy."
    },
    {
      "name": "Seafood Express",
      "image":
          "https://images.unsplash.com/photo-1600891964599-f61ba0e24092?w=700",
      "menu": [
        {"name": "Udang Saus Padang", "price": 40000},
        {"name": "Cumi Goreng Tepung", "price": 35000}
      ],
      "rating": 4.7,
      "distance": 2.1,
      "desc":
          "Hidangan laut segar dengan cita rasa khas pantai, cocok untuk pecinta seafood!"
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPlaces = places.where((place) {
      final q = searchQuery.toLowerCase();
      final nameMatch = place["name"].toLowerCase().contains(q);
      final menuMatch = place["menu"]
          .any((m) => m["name"].toLowerCase().contains(q));
      return nameMatch || menuMatch;
    }).toList();

    if (sortType == "Termurah") {
      filteredPlaces.sort((a, b) =>
          a["menu"].first["price"].compareTo(b["menu"].first["price"]));
    } else if (sortType == "Terdekat") {
      filteredPlaces.sort((a, b) => a["distance"].compareTo(b["distance"]));
    }

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
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Cari tempat / menu...",
                      prefixIcon:
                          const Icon(Icons.search, color: AppColors.brownDark),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: AppColors.lightGrey),
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
                    PopupMenuItem(value: "Terdekat", child: Text("Terdekat")),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredPlaces.isEmpty
                ? const Center(
                    child: Text(
                      "Tempat atau menu tidak ditemukan.",
                      style: TextStyle(color: AppColors.brownDark),
                    ),
                  )
                : ListView.builder(
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
                                  p["image"],
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    height: 180,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.broken_image,
                                        size: 60, color: AppColors.brownDark),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p["name"],
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.brownDark),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.amber, size: 16),
                                        const SizedBox(width: 4),
                                        Text("${p["rating"]} • ${p["distance"]} km",
                                            style: const TextStyle(
                                                color: Colors.black54)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      p["desc"],
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87),
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
        ],
      ),
    );
  }

  void _openDetail(Map<String, dynamic> place) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(place["name"]),
        content: Text(
            "Rata-rata rating: ${place["rating"]}\nJarak: ${place["distance"]} km\n\n${place["desc"]}"),
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
