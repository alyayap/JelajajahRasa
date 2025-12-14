import 'package:flutter/material.dart';
import '../theme.dart';

class MenuDetailPage extends StatefulWidget {
  final Map<String, String> item;
  const MenuDetailPage({super.key, required this.item});

  @override
  State<MenuDetailPage> createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends State<MenuDetailPage> {
  double portion = 1;

  final Map<String, Map<String, int>> dummyNutrition = {
    'Kopi Tubruk': {'cal': 40, 'price': 12000},
    'Roti Bakar': {'cal': 250, 'price': 10000},
    'Nasi Goreng Spesial': {'cal': 520, 'price': 35000},
    'Rendang Daging': {'cal': 610, 'price': 55000},
    'Cold Brew': {'cal': 60, 'price': 28000},
    'Croissant': {'cal': 300, 'price': 18000},
  };

  int get baseCal =>
      dummyNutrition[widget.item['name']]?['cal'] ?? 200;

  int get basePrice =>
      dummyNutrition[widget.item['name']]?['price'] ?? 20000;

  @override
  Widget build(BuildContext context) {
    final totalCal = (baseCal * portion).round();
    final totalPrice = (basePrice * portion).round();

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: Text(widget.item['name']!,
            style: const TextStyle(color: AppColors.brownDark)),
        backgroundColor: AppColors.whiteSoft,
        iconTheme: const IconThemeData(color: AppColors.brownDark),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.item['img']!,
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.item['name']!,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),

                  Text(widget.item['desc'] ?? '',
                      style: const TextStyle(fontSize: 16)),

                  const SizedBox(height: 20),
                  const Divider(),

                  // ===== CALORIES & BUDGET ESTIMATOR =====
                  const Text(
                    'Calories & Budget Estimator',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 12),

                  Text('Porsi: ${portion.toStringAsFixed(1)}x'),

                  Slider(
                    value: portion,
                    min: 0.5,
                    max: 3,
                    divisions: 5,
                    label: '${portion.toStringAsFixed(1)}x',
                    onChanged: (v) {
                      setState(() => portion = v);
                    },
                  ),

                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.whiteSoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _row('Estimasi Kalori', '$totalCal kcal'),
                        const SizedBox(height: 8),
                        _row('Estimasi Harga',
                            'Rp ${totalPrice.toString()}'),
                        const SizedBox(height: 6),
                        const Text(
                          '*Estimasi berdasarkan data dummy',
                          style: TextStyle(
                              fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brownSoft,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Ditambahkan ke favorit (dummy)')),
                        );
                      },
                      child: const Text('Tambahkan ke Favorit'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String l, String r) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(l),
        Text(r,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
