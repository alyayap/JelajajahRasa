import 'package:flutter/material.dart';
import '../theme.dart';
import 'package:flutter/services.dart';
import 'profileinfo_page.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> post;
  const DetailPage({super.key, required this.post});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _commentController = TextEditingController();
  late List<Map<String, String>> _comments;

  @override
  void initState() {
    super.initState();
    final existing = widget.post['comments'];
    if (existing != null && existing is List) {
      _comments = List<Map<String, String>>.from(
        existing.map((c) => Map<String, String>.from(c)),
      );
    } else {
      _comments = [];
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addComment(String text) {
    if (text.trim().isEmpty) return;
    final newComment = {
      'user': 'kamu',
      'text': text.trim(),
      'time': 'baru saja',
    };
    setState(() {
      _comments.insert(0, newComment);
      widget.post['comments'] = _comments;
      _commentController.clear();
    });
    FocusScope.of(context).unfocus();
  }

  void _showShareDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Bagikan'),
        content:
            Text('Bagikan postingan "${widget.post['name']}" ke temanmu?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Clipboard.setData(
                ClipboardData(
                    text:
                        'https://jelajah-rasa.app/post/${widget.post['account']}'),
              );
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Berhasil'),
                  content:
                      const Text('Link telah disalin ke clipboard ✅'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Bagikan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.whiteSoft,
        iconTheme: const IconThemeData(color: AppColors.brownDark),
        title: Text(
          post['name'],
          style: const TextStyle(
            color: AppColors.brownDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: AppColors.brownDark),
            onPressed: _showShareDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Stack(
                  children: [
                    Image.network(
                      post['image'],
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(
                        height: 300,
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.broken_image, size: 60),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              '${post['rating']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 14),
                            const Icon(Icons.location_on,
                                color: Colors.white, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              post['location'],
                              style:
                                  const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔹 Judul
                      Text(
                        post['name'],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.brownDark,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // 🔹 Deskripsi
                      Text(
                        post['caption'],
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 🔹 Tombol interaksi
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                post['liked'] = !(post['liked'] as bool);
                                if (post['liked'] == true) {
                                  post['likes'] =
                                      (post['likes'] as int) + 1;
                                }
                              });
                            },
                            icon: Icon(
                              post['liked']
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: post['liked']
                                  ? Colors.red
                                  : AppColors.brownDark,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() =>
                                  post['saved'] = !(post['saved'] as bool));
                            },
                            icon: Icon(
                              post['saved']
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: AppColors.brownDark,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text('${post['likes']} suka'),
                        ],
                      ),

                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 8),

                      // 🔹 Komentar
                      const Text(
                        'Komentar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.brownDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (_comments.isEmpty)
                        const Text(
                          'Belum ada komentar. Jadilah yang pertama!',
                        ),
                      ..._comments
                          .map(
                            (c) => ListTile(
                              leading: const CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200',
                                ),
                              ),
                              title: Text(
                                c['user']!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(c['text']!),
                              trailing: Text(c['time'] ?? ''),
                            ),
                          )
                          .toList(),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Input komentar
          SafeArea(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: AppColors.whiteSoft,
                border: Border(
                  top: BorderSide(color: AppColors.cream),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: 'Tulis komentar...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFF5F2EA),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () =>
                        _addComment(_commentController.text),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brownSoft,
                    ),
                    child: const Text('Kirim'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
