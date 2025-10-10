import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../theme.dart';

class PlaceDetail extends StatefulWidget {
  final Map<String, dynamic> place;
  const PlaceDetail({super.key, required this.place});

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  // Tambah Menu Baru
  void _addMenuItem() {
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tambah Menu Baru'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Nama Menu'),
            ),
            TextField(
              controller: priceCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Harga (Rp)'),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              final name = nameCtrl.text.trim();
              final price = double.tryParse(priceCtrl.text.trim()) ?? 0;
              if (name.isNotEmpty && price > 0) {
                setState(() {
                  (widget.place['menu'] as List).add({
                    'id': const Uuid().v4(),
                    'name': name,
                    'price': price,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  // Edit Menu
  void _editMenuItem(Map<String, dynamic> item) {
    final nameCtrl = TextEditingController(text: item['name']);
    final priceCtrl = TextEditingController(text: item['price'].toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Menu'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Nama Menu'),
            ),
            TextField(
              controller: priceCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Harga (Rp)'),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              final newName = nameCtrl.text.trim();
              final newPrice = double.tryParse(priceCtrl.text.trim()) ?? 0;
              if (newName.isNotEmpty && newPrice > 0) {
                setState(() {
                  item['name'] = newName;
                  item['price'] = newPrice;
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  // Hapus Menu
  void _deleteMenuItem(String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Menu'),
        content: const Text('Yakin ingin menghapus menu ini?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              setState(() {
                (widget.place['menu'] as List)
                    .removeWhere((m) => m['id'] == id);
              });
              Navigator.pop(context);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.place;
    final List menuList = (p['menu'] ?? []) as List;

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.whiteSoft,
        title: Text(
          p['name'] ?? 'Detail Tempat',
          style: const TextStyle(
              color: AppColors.brownDark, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: AppColors.brownDark),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMenuItem,
        backgroundColor: AppColors.brownMain,
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              p['image'] ?? '',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                height: 200,
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported, size: 50),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            p['name'] ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          Text(
            p['location'] ?? '',
            style: const TextStyle(color: Colors.grey),
          ),
          const Divider(height: 30),
          const Text(
            'Daftar Menu',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),

          // List menu
          if (menuList.isEmpty)
            const Text('Belum ada menu.')
          else
            ...menuList.map((m) => Card(
                  child: ListTile(
                    title: Text(m['name']),
                    subtitle: Text('Rp ${m['price'].toStringAsFixed(0)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.edit, color: Colors.amberAccent),
                          onPressed: () => _editMenuItem(m),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _deleteMenuItem(m['id']),
                        ),
                      ],
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
