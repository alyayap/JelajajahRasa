import 'package:flutter/material.dart';
import '../theme.dart';
import 'detail_page.dart';

class SearchPage extends StatefulWidget {
  final List<Map<String, dynamic>> allPosts;
  const SearchPage({super.key, required this.allPosts});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String q = '';
  List<Map<String, dynamic>> get results {
    final t = q.trim().toLowerCase();
    if (t.isEmpty) return widget.allPosts;
    return widget.allPosts.where((p) {
      final name = (p['name'] as String).toLowerCase();
      final loc = (p['location'] as String).toLowerCase();
      final cat = (p['category'] as String).toLowerCase();
      return name.contains(t) || loc.contains(t) || cat.contains(t);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cari', style: TextStyle(color: AppColors.brownDark)), backgroundColor: AppColors.whiteSoft),
      body: Column(children: [
        Container(margin: const EdgeInsets.all(12), padding: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(color: AppColors.whiteSoft, borderRadius: BorderRadius.circular(12)), child: TextField(autofocus: true, onChanged: (v) => setState(() => q = v), decoration: const InputDecoration(icon: Icon(Icons.search), hintText: 'Ketik untuk mencari...', border: InputBorder.none))),
        Expanded(child: ListView.builder(itemCount: results.length, itemBuilder: (context, i) {
          final p = results[i];
          return ListTile(leading: CircleAvatar(backgroundImage: NetworkImage(p['profile'])), title: Text(p['name']), subtitle: Text('${p['location']} • ${p['category']}'), onTap: () async { await Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(post: p))); setState(() {}); });
        }))
      ]),
    );
  }
}