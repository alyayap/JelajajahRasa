import 'package:flutter/material.dart';
import '../theme.dart';

class MenuDetailPage extends StatelessWidget {
  final Map<String, String> item;
  const MenuDetailPage({super.key, this.item = const {'name':'','price':'','img':'','desc':''}});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item['name']!, style: const TextStyle(color: AppColors.brownDark)), backgroundColor: AppColors.whiteSoft),
      body: SingleChildScrollView(child: Column(children: [
        Image.network(item['img']!, height: 260, width: double.infinity, fit: BoxFit.cover, errorBuilder: (_,__,___) => Container(height: 260, color: Colors.grey[200], child: const Center(child: Icon(Icons.broken_image)))),
        Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item['name']!, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.brownDark)),
          const SizedBox(height: 8),
          Text(item['price']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(item['desc'] ?? 'Deskripsi tidak tersedia', style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tambah ke favorit (simulasi)'))); }, style: ElevatedButton.styleFrom(backgroundColor: AppColors.brownSoft), child: const Text('Tambahkan ke Favorit'))),
        ])),
      ])),
    );
  }
}