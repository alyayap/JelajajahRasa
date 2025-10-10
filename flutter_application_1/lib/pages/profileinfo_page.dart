import 'package:flutter/material.dart';
import '../theme.dart';
import 'edit_profile_page.dart';
import 'menu_detail_page.dart';
import 'saved_posts_page.dart';
import 'package:flutter/services.dart';

class ProfileInfoPage extends StatefulWidget {
  final String username; // nama tempat (ditampilkan)
  final bool isMyProfile; // true = halaman pemilik (boleh edit)
  final List<Map<String, dynamic>>? postsRef; // referensi posting (opsional)
  final String? uniqueData; // id/account untuk membedakan tiap profil

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

  late int followers;
  late int following;
  bool isFollowing = false;

  // menus & reviews per profile — kita bisa memilih daftar yang berbeda berdasarkan uniqueData
  late List<Map<String, String>> menu;
  late List<Map<String, String>> reviews;
  late List<Map<String, String>> gallery;

  @override
  void initState() {
    super.initState();

    // inisialisasi umum
    placeName = widget.username;
    category = 'Warkop';
    description =
        'Kedai kecil dengan suasana hangat — kopi enak, roti bakar rumah, cocok untuk kumpul santai. Kami hadir dengan bahan lokal berkualitas dan ambience yang ramah.';
    location = 'Jl. Contoh No.1';
    mapsLink = 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(location)}';

    // default followers/following, diambil acak ringan dari hash uniqueData untuk beda-beda antar profil
    final seed = (widget.uniqueData ?? widget.username).codeUnits.fold<int>(0, (a, b) => a + b);
    followers = 200 + (seed % 1000);
    following = 20 + (seed % 300);

    // default gallery/menu/review; disesuaikan per account agar tiap profil berbeda
    gallery = _galleryFor(widget.uniqueData);
    menu = _menuFor(widget.uniqueData);
    reviews = _reviewsFor(widget.uniqueData);
  }

  // helper: pilih galeri berbeda berdasar id
  List<Map<String, String>> _galleryFor(String? id) {
    final maps = <String, List<String>>{
      'warkop_santai': [
        'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=1000',
        'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=1000',
        'https://images.unsplash.com/photo-1515444744559-1b8b8d7f9b5b?w=1000',
      ],
      'resto_nusantara': [
        'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?w=1000',
        'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=1000',
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=1000',
      ],
      'caffe_petang': [
        'https://images.unsplash.com/photo-1517705008129-13f6a4d7b736?w=1000',
        'https://images.unsplash.com/photo-1517685352821-92cf88aee5a5?w=1000',
        'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=1000',
      ],
    };

    final key = (id ?? '').toLowerCase();
    final chosen = maps.containsKey(key) ? maps[key]! : [
      'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=1000',
      'https://images.unsplash.com/photo-1544025162-d76694265947?w=1000',
      'https://images.unsplash.com/photo-1526318472351-c75fcf070c98?w=1000',
    ];

    return chosen.map((u) => {'image': u}).toList();
  }

  // helper: menu berbeda-beda
  List<Map<String, String>> _menuFor(String? id) {
    final key = (id ?? '').toLowerCase();
    if (key.contains('resto')) {
      return [
        {'name': 'Nasi Goreng Spesial', 'price': 'Rp35.000', 'img': 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?w=600', 'desc': 'Nasi goreng khas rumah.'},
        {'name': 'Rendang Daging', 'price': 'Rp55.000', 'img': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600', 'desc': 'Rendang empuk kaya rempah.'},
      ];
    } else if (key.contains('caffe')) {
      return [
        {'name': 'Cold Brew', 'price': 'Rp28.000', 'img': 'https://images.unsplash.com/photo-1498804103079-a6351b050096?w=600', 'desc': 'Cold brew lembut.'},
        {'name': 'Croissant', 'price': 'Rp18.000', 'img': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600', 'desc': 'Croissant mentega.'},
      ];
    } else {
      // default warkop / street food
      return [
        {'name': 'Kopi Tubruk', 'price': 'Rp12.000', 'img': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600', 'desc': 'Kopi tubruk gula jawa.'},
        {'name': 'Roti Bakar', 'price': 'Rp10.000', 'img': 'https://images.unsplash.com/photo-1546069901-eacef0df6022?w=600', 'desc': 'Roti bakar spesial.'},
      ];
    }
  }

  // helper: reviews berbeda
  List<Map<String, String>> _reviewsFor(String? id) {
    final key = (id ?? '').toLowerCase();
    if (key.contains('santai')) {
      return [
        {'user': 'ani_traveler', 'text': 'Suasananya hangat dan cocok buat kerja remote.', 'media': '', 'time': '2d', 'rating': '5'},
        {'user': 'rifky', 'text': 'Kopi mantap, roti bakar recommended.', 'media': '', 'time': '3d', 'rating': '4'},
      ];
    } else if (key.contains('nusantara')) {
      return [
        {'user': 'dian_food', 'text': 'Rasa otentik Nusantara, porsi besar.', 'media': '', 'time': '1d', 'rating': '5'},
        {'user': 'tomi', 'text': 'Suka rendangnya—empuk sekali.', 'media': '', 'time': '5d', 'rating': '5'},
      ];
    } else {
      return [
        {'user': 'nina_cafe', 'text': 'Cozy banget, cocok ngumpul bareng teman.', 'media': '', 'time': '4d', 'rating': '4'},
        {'user': 'andi_food', 'text': 'Pelayanan ramah dan cepat.', 'media': '', 'time': '6d', 'rating': '4'},
      ];
    }
  }

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
    if (result != null && result is Map<String, String>) {
      setState(() {
        placeName = result['name'] ?? placeName;
        category = result['category'] ?? category;
        description = result['description'] ?? description;
        location = result['location'] ?? location;
        mapsLink = result['mapsLink'] ?? mapsLink;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil diperbarui')));
    }
  }

  void _shareProfile() {
    Clipboard.setData(ClipboardData(text: 'https://jelajah-rasa.app/place/${placeName.replaceAll(' ', '-').toLowerCase()}'));
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Bagikan'),
        content: const Text('Link profil disalin ke clipboard'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
      ),
    );
  }

  void _openMaps() {
    Clipboard.setData(ClipboardData(text: mapsLink));
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Google Maps'),
        content: const Text('Link Google Maps disalin ke clipboard'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
      ),
    );
  }

  void _openMenuDetail(Map<String, String> item) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => MenuDetailPage(item: item)));
  }

  Future<void> _openSaved() async {
    if (widget.postsRef == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data posting tidak tersedia')));
      return;
    }
    await Navigator.push(context, MaterialPageRoute(builder: (_) => SavedPostsPage(postsRef: widget.postsRef!)));
    setState(() {});
  }

  double get averageRating {
    if (reviews.isEmpty) return 0;
    final sum = reviews.map((r) => double.tryParse(r['rating'] ?? '0') ?? 0).reduce((a, b) => a + b);
    return sum / reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: Text(placeName, style: const TextStyle(color: AppColors.brownDark)),
        backgroundColor: AppColors.whiteSoft,
        centerTitle: true,
        actions: [
          IconButton(onPressed: _shareProfile, icon: const Icon(Icons.share, color: AppColors.brownDark))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 14),
            CircleAvatar(
              radius: 56,
              backgroundImage: NetworkImage(_profileImageFor(widget.uniqueData)),
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 10),
            Text(placeName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.brownDark)),
            const SizedBox(height: 6),
            Text('$category • $location', style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 12),

            // followers / following + action button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Text(followers.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Text('Followers', style: TextStyle(color: Colors.black54, fontSize: 13))
                  ]),
                  // tombol Edit (jika owner) atau Ikuti (jika bukan owner)
                  widget.isMyProfile
                      ? OutlinedButton(
                          onPressed: _editProfile,
                          style: OutlinedButton.styleFrom(backgroundColor: AppColors.cream, side: const BorderSide(color: Color(0xFFDDB892))),
                          child: const Text('Edit Profil', style: TextStyle(color: AppColors.linkBlue)),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isFollowing = !isFollowing;
                              followers += isFollowing ? 1 : -1;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(isFollowing ? 'Anda mengikuti $placeName' : 'Berhenti mengikuti $placeName')),
                            );
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: isFollowing ? AppColors.whiteSoft : AppColors.brownSoft, foregroundColor: isFollowing ? AppColors.brownDark : Colors.white),
                          child: Text(isFollowing ? 'Mengikuti' : 'Ikuti'),
                        ),
                  Column(children: [
                    Text(following.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Text('Following', style: TextStyle(color: Colors.black54, fontSize: 13))
                  ]),
                ],
              ),
            ),

            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(children: [
                Text(description, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black87)),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 6),
                  Text(averageRating.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text('(${reviews.length} ulasan)', style: const TextStyle(color: Colors.black54)),
                ])
              ]),
            ),

            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.map_outlined, color: AppColors.brownMain),
              title: const Text('Buka di Google Maps'),
              subtitle: Text(location),
              onTap: _openMaps,
            ),
            const Divider(),
            const SizedBox(height: 8),

            // Tabs: Postingan / Ulasan / Menu
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(indicatorColor: AppColors.brownSoft, labelColor: AppColors.brownDark, tabs: [
                    Tab(icon: Icon(Icons.grid_on), text: 'Postingan'),
                    Tab(icon: Icon(Icons.comment), text: 'Ulasan'),
                    Tab(icon: Icon(Icons.menu_book), text: 'Daftar Menu'),
                  ]),
                  SizedBox(
                    height: 420,
                    child: TabBarView(children: [
                      // postingan grid (pakai gallery berbeda)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.count(
                          crossAxisCount: 3,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 6,
                          children: gallery
                              .map((g) => ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(g['image']!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.grey[200], child: const Icon(Icons.broken_image))),
                                  ))
                              .toList(),
                        ),
                      ),

                      // ulasan list
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                          itemCount: reviews.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, i) {
                            final r = reviews[i];
                            return ListTile(
                              leading: const CircleAvatar(backgroundImage: NetworkImage('https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200')),
                              title: Text(r['user']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(r['text']!),
                                const SizedBox(height: 6),
                                if (r['media'] != null && r['media']!.isNotEmpty)
                                  GestureDetector(
                                    onTap: () {
                                      final media = r['media']!;
                                      if (media.endsWith('.mp4')) {
                                        Clipboard.setData(ClipboardData(text: media));
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link video disalin ke clipboard')));
                                      } else {
                                        showDialog(context: context, builder: (_) => Dialog(child: Image.network(media, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const SizedBox(height: 200, child: Center(child: Icon(Icons.broken_image))))));
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 6),
                                      width: 120,
                                      height: 80,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[200]),
                                      child: Stack(alignment: Alignment.center, children: [
                                        ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(r['media']!, width: double.infinity, height: 80, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const SizedBox())),
                                        if (r['media']!.endsWith('.mp4')) const Icon(Icons.play_circle_outline, size: 34, color: Colors.white),
                                      ]),
                                    ),
                                  ),
                              ]),
                              trailing: Text(r['time'] ?? ''),
                            );
                          },
                        ),
                      ),

                      // daftar menu
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: menu.length,
                          itemBuilder: (context, i) {
                            final m = menu[i];
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(m['img']!, width: 58, height: 58, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.grey[200], child: const Icon(Icons.broken_image))),
                              ),
                              title: Text(m['name']!),
                              subtitle: Text(m['price']!),
                              trailing: ElevatedButton(
                                onPressed: () => _openMenuDetail(m),
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.brownSoft),
                                child: const Text('Lihat'),
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
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
          if (i == 0) {
            Navigator.pop(context); // kembali ke home (tidak mengubah tab feed)
          } else if (i == 1) {
            Navigator.pushNamed(context, '/posting');
          } else if (i == 2) {
            await _openSaved();
          }
        },
        selectedItemColor: AppColors.brownDark,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: 'Posting'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Simpan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }

  // helper sederhana untuk memilih gambar avatar unik
  String _profileImageFor(String? id) {
    final key = (id ?? '').toLowerCase();
    final map = {
      'warkop_santai': 'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=300',
      'resto_nusantara': 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?w=300',
      'caffe_petang': 'https://images.unsplash.com/photo-1517705008129-13f6a4d7b736?w=300',
      'bakso_juara': 'https://images.unsplash.com/photo-1514518872867-1c0a2a2a7f1b?w=300',
      'pawon_gendut': 'https://images.unsplash.com/photo-1525610553991-2bede1a236e2?w=300',
      'mie_aceh_original': 'https://images.unsplash.com/photo-1570610155223-4a84b99b2f18?w=300',
      'dessert_corner': 'https://images.unsplash.com/photo-1526318472351-c75fcf070c98?w=300',
      'sate_pak_darto': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=300',
      'kopi_hitam_manis': 'https://images.unsplash.com/photo-1504198453319-5ce911bafcde?w=300',
      'seafood_lezat': 'https://images.unsplash.com/photo-1617196035137-5c3b11b0b113?w=300',
    };
    return map[key] ?? 'https://i.pravatar.cc/300?u=${placeName.replaceAll(' ', '')}';
  }
}
