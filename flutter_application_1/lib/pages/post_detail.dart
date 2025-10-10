import 'package:flutter/material.dart';
import '../theme.dart';
import 'place_detail.dart';

class PostDetail extends StatelessWidget {
  final Map<String, dynamic> post;
  const PostDetail({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final place = post['place'] ?? {
      'name': post['restaurantName'] ?? 'Tempat Tidak Diketahui',
      'location': post['location'] ?? 'Lokasi tidak diketahui',
      'image': post['imageUrl'] ?? '',
      'menu': post['menu'] ?? [],
    };

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const Text(
          'Detail Postingan',
          style: TextStyle(
            color: AppColors.brownDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.whiteSoft,
        iconTheme: const IconThemeData(color: AppColors.brownDark),
      ),
      body: ListView(
        children: [
          // 🔹 Gambar utama
          Image.network(
            post['imageUrl'] ?? '',
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Container(
              height: 300,
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.broken_image, size: 60, color: Colors.brown),
              ),
            ),
          ),

          // 🔹 Konten teks
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['restaurantName'] ?? 'Tanpa Nama',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brownDark,
                  ),
                ),
                const SizedBox(height: 8),

                if (post['price'] != null)
                  Text(
                    'Harga rata-rata: Rp ${post['price']}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.redAccent),
                    const SizedBox(width: 4),
                    Text(post['location'] ?? 'Lokasi tidak diketahui'),
                  ],
                ),
                const SizedBox(height: 14),

                Text(
                  post['caption'] ??
                      'Deskripsi tidak tersedia untuk postingan ini.',
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 20),

                // 🔹 Tombol buka profil tempat
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brownMain,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlaceDetail(place: place),
                      ),
                    );
                  },
                  icon: const Icon(Icons.store, color: Colors.white),
                  label: const Text(
                    'Lihat Profil Tempat',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
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
