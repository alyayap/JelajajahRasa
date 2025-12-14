import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';
import 'edit_profile_page.dart';
import 'menu_detail_page.dart';
import 'saved_posts_page.dart';
import 'food_journey_page.dart';

class ProfileInfoPage extends StatefulWidget {
  final String username;
  final bool isMyProfile;
  final List<Map<String, dynamic>>? postsRef;
  final String? uniqueData;

  const ProfileInfoPage({
    super.key,
    required this.username,
    this.isMyProfile = false,
    this.postsRef,
    this.uniqueData,
  });

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  late String placeName;
  late String category;
  late String description;
  late String location;
  late String mapsLink;

  String? profileImagePath;

  late int followers;
  late int following;
  bool isFollowing = false;

  late List<Map<String, String>> menu;
  late List<Map<String, String>> reviews;
  late List<Map<String, String>> gallery;

  @override
  void initState() {
    super.initState();

    placeName = widget.username;
    category = 'Warkop';
    description =
        'Kedai kecil dengan suasana hangat — kopi enak, roti bakar rumah, cocok untuk kumpul santai.';
    location = 'Jl. Contoh No.1';
    mapsLink =
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(location)}';

    final seed = (widget.uniqueData ?? widget.username)
        .codeUnits
        .fold<int>(0, (a, b) => a + b);
    followers = 200 + (seed % 1000);
    following = 20 + (seed % 300);

    gallery = _galleryFor(widget.uniqueData);
    menu = _menuFor(widget.uniqueData);
    reviews = _reviewsFor(widget.uniqueData);
  }

  // ================= EDIT PROFILE =================
  Future<void> _editProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfilePage(
          name: placeName,
          category: category,
          description: description,
          location: location,
          mapsLink: mapsLink,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        if (result['imageFile'] != null) {
          profileImagePath = result['imageFile'];
        }
        placeName = result['name'] ?? placeName;
        category = result['category'] ?? category;
        description = result['description'] ?? description;
        location = result['location'] ?? location;
        mapsLink = result['mapsLink'] ?? mapsLink;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Profil diperbarui')));
    }
  }

  // ================= ACTIONS =================
  void _shareProfile() {
    Clipboard.setData(
      ClipboardData(
        text:
            'https://jelajah-rasa.app/place/${placeName.replaceAll(' ', '-').toLowerCase()}',
      ),
    );
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('Bagikan'),
        content: Text('Link profil disalin ke clipboard'),
      ),
    );
  }

  void _openMaps() {
    Clipboard.setData(ClipboardData(text: mapsLink));
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('Google Maps'),
        content: Text('Link Google Maps disalin ke clipboard'),
      ),
    );
  }

  void _openMenuDetail(Map<String, String> item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MenuDetailPage(item: item)),
    );
  }

  Future<void> _openSaved() async {
    if (widget.postsRef == null) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SavedPostsPage(postsRef: widget.postsRef!),
      ),
    );
    setState(() {});
  }

  double get averageRating {
    if (reviews.isEmpty) return 0;
    final sum = reviews
        .map((r) => double.tryParse(r['rating'] ?? '0') ?? 0)
        .reduce((a, b) => a + b);
    return sum / reviews.length;
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title:
            Text(placeName, style: const TextStyle(color: AppColors.brownDark)),
        backgroundColor: AppColors.whiteSoft,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _shareProfile,
            icon: const Icon(Icons.share, color: AppColors.brownDark),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 14),

            // ===== AVATAR =====
            CircleAvatar(
              radius: 56,
              backgroundImage: profileImagePath != null
                  ? FileImage(File(profileImagePath!))
                  : NetworkImage(_profileImageFor(widget.uniqueData))
                      as ImageProvider,
              backgroundColor: Colors.grey[200],
            ),

            const SizedBox(height: 10),

            Text(
              placeName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.brownDark,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              '$category • $location',
              style: const TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 12),

            // ===== FOLLOW / EDIT =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _count('Followers', followers),
                  widget.isMyProfile
                      ? OutlinedButton(
                          onPressed: _editProfile,
                          child: const Text('Edit Profil'),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isFollowing = !isFollowing;
                              followers += isFollowing ? 1 : -1;
                            });
                          },
                          child: Text(isFollowing ? 'Mengikuti' : 'Ikuti'),
                        ),
                  _count('Following', following),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  Text(description, textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 6),
                      Text(averageRating.toStringAsFixed(1)),
                      const SizedBox(width: 6),
                      Text(
                        '(${reviews.length} ulasan)',
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ===== MAPS =====
            ListTile(
              leading: const Icon(Icons.map_outlined),
              title: const Text('Buka di Google Maps'),
              subtitle: Text(location),
              onTap: _openMaps,
            ),

            // ===== FOOD JOURNEY =====
            ListTile(
              leading: const Icon(Icons.timeline),
              title: const Text('Food Journey'),
              subtitle: const Text('Riwayat tempat yang pernah dikunjungi'),
              onTap: () {
                if (widget.postsRef == null) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        FoodJourneyPage(posts: widget.postsRef!),
                  ),
                );
              },
            ),

            const Divider(),

            // ===== TABS =====
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(tabs: [
                    Tab(text: 'Postingan'),
                    Tab(text: 'Ulasan'),
                    Tab(text: 'Menu'),
                  ]),
                  SizedBox(
                    height: 420,
                    child: TabBarView(
                      children: [
                        GridView.count(
                          crossAxisCount: 3,
                          padding: const EdgeInsets.all(8),
                          children: gallery
                              .map((g) => Image.network(
                                    g['image']!,
                                    fit: BoxFit.cover,
                                  ))
                              .toList(),
                        ),
                        ListView(
                          children: reviews
                              .map(
                                (r) => ListTile(
                                  title: Text(r['user']!),
                                  subtitle: Text(r['text']!),
                                  trailing: Text(r['rating']!),
                                ),
                              )
                              .toList(),
                        ),
                        ListView(
                          children: menu
                              .map(
                                (m) => ListTile(
                                  leading: Image.network(
                                    m['img']!,
                                    width: 48,
                                    height: 48,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(m['name']!),
                                  subtitle: Text(m['price']!),
                                  trailing: ElevatedButton(
                                    onPressed: () => _openMenuDetail(m),
                                    child: const Text('Lihat'),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        onTap: (i) async {
          if (i == 0) Navigator.pop(context);
          if (i == 2) await _openSaved();
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Posting'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Simpan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }

  Widget _count(String label, int value) {
    return Column(
      children: [
        Text(
          '$value',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(label, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }

  // ================= DUMMY DATA =================
  List<Map<String, String>> _galleryFor(String? id) => [
        {
          'image':
              'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=1000'
        },
        {
          'image':
              'https://images.unsplash.com/photo-1544025162-d76694265947?w=1000'
        },
        {
          'image':
              'https://images.unsplash.com/photo-1526318472351-c75fcf070c98?w=1000'
        },
      ];

  List<Map<String, String>> _menuFor(String? id) => [
        {
          'name': 'Kopi Tubruk',
          'price': 'Rp12.000',
          'img':
              'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600',
          'desc': 'Kopi tubruk gula jawa'
        },
      ];

  List<Map<String, String>> _reviewsFor(String? id) => [
        {
          'user': 'ani_traveler',
          'text': 'Tempatnya nyaman!',
          'rating': '5'
        },
      ];

  String _profileImageFor(String? id) =>
      'https://i.pravatar.cc/300?u=$placeName';
}
