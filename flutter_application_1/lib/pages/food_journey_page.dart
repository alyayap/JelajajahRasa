import 'package:flutter/material.dart';
import '../theme.dart';

class FoodJourneyPage extends StatelessWidget {
  final List<Map<String, dynamic>> posts;
  const FoodJourneyPage({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    final visited =
        posts.where((p) => p['visited'] == true).toList().reversed.toList();

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const Text('Food Journey',
            style: TextStyle(color: AppColors.brownDark)),
        backgroundColor: AppColors.whiteSoft,
        iconTheme: const IconThemeData(color: AppColors.brownDark),
      ),
      body: visited.isEmpty
          ? const Center(child: Text('Belum ada perjalanan kuliner'))
          : ListView.builder(
              itemCount: visited.length,
              itemBuilder: (context, i) {
                final p = visited[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(p['profile']),
                  ),
                  title: Text(p['name']),
                  subtitle: Text(
                    '${p['location']} • ${p['visitedDate'] ?? 'Tanggal tidak diketahui'}',
                  ),
                );
              },
            ),
    );
  }
}
