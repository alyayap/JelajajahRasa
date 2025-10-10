import 'package:flutter/material.dart';
import '../theme.dart';
import 'detail_page.dart';

class SavedPostsPage extends StatefulWidget {
  final List<Map<String, dynamic>> postsRef;
  const SavedPostsPage({super.key, required this.postsRef});

  @override
  State<SavedPostsPage> createState() => _SavedPostsPageState();
}

class _SavedPostsPageState extends State<SavedPostsPage> {
  @override
  Widget build(BuildContext context) {
    final saved = widget.postsRef.where((p) => p['saved'] == true).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Disimpan', style: TextStyle(color: AppColors.brownDark)), backgroundColor: AppColors.whiteSoft),
      body: saved.isEmpty ? const Center(child: Text('Belum ada postingan disimpan')) : ListView.builder(itemCount: saved.length, itemBuilder: (context, i) {
        final p = saved[i];
        return ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(p['profile'])),
          title: Text(p['name']),
          subtitle: Text(p['location']),
          trailing: IconButton(icon: const Icon(Icons.remove_circle_outline, color: Colors.red), onPressed: () { setState(() { p['saved'] = false; }); }),
          onTap: () async { await Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(post: p))); setState(() {}); },
        );
      }),
    );
  }
}