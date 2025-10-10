// lib/pages/home_feed.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';
import 'detail_page.dart';
import 'profileinfo_page.dart';
import 'saved_posts_page.dart';
import 'search_page.dart';
import 'posting_page.dart';

class HomeFeed extends StatefulWidget {
  const HomeFeed({Key? key}) : super(key: key);

  @override
  State<HomeFeed> createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  int _selectedIndex = 0;
  String query = '';
  String selectedFilter = 'Semua';

  // ====== DATA: 15 posts, unique profiles & images (Unsplash links) ======
  final List<Map<String, dynamic>> posts = [
    {
      'account': 'warkop_santai',
      'profile': 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=200',
      'name': 'Warkop Santai Pagi',
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=1400',
      'category': 'Warkop',
      'price': 'Rp12.000',
      'location': 'Malang',
      'rating': 4.6,
      'likes': 150,
      'saved': false,
      'liked': false,
      'caption':
          'Kopi hitam & roti bakar renyah — suasana pagi yang menenangkan. Ada colokan & Wi-Fi, cocok untuk kerja santai atau ngobrol bareng sahabat. Spesial: roti bakar gula aren. #cozy #kopi',
      'comments': [
        {'user': 'ani_traveler', 'text': 'Suasananya enak!', 'time': '2h'}
      ]
    },
    {
      'account': 'resto_nusantara',
      'profile': 'https://images.unsplash.com/photo-1544025162-d76694265947?w=200',
      'name': 'Resto Nusantara',
      'image': 'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=1400',
      'category': 'Restoran',
      'price': 'Rp40.000',
      'location': 'Jakarta',
      'rating': 4.8,
      'likes': 320,
      'saved': true,
      'liked': false,
      'caption':
          'Rasa Nusantara dikemas modern: rendang empuk, nasi goreng spesial, dan sambal rahasia. Cocok untuk keluarga atau acara kecil dengan suasana hangat.',
      'comments': []
    },
    {
      'account': 'caffe_petang',
      'profile': 'https://images.unsplash.com/photo-1517705008129-13f6a4d7b736?w=200',
      'name': 'Caffe Kopi Petang',
      'image': 'https://images.unsplash.com/photo-1517685352821-92cf88aee5a5?w=1400',
      'category': 'Caffe',
      'price': 'Rp30.000',
      'location': 'Bandung',
      'rating': 4.7,
      'likes': 270,
      'saved': false,
      'liked': true,
      'caption':
          'Caffe kekinian dengan aroma kopi khas. Spot instagramable & pastry homemade — pas buat kerja atau hangout sore. Cold brew weekly special tersedia.',
      'comments': []
    },
    {
      'account': 'sate_pak_darto',
      'profile': 'https://images.unsplash.com/photo-1525755662778-989d0524087e?w=200',
      'name': 'Sate Madura Pak Darto',
      'image': 'https://images.unsplash.com/photo-1546069901-eacef0df6022?w=1400',
      'category': 'Street Food',
      'price': 'Rp20.000',
      'location': 'Surabaya',
      'rating': 4.9,
      'likes': 420,
      'saved': false,
      'liked': false,
      'caption':
          'Sate asli Madura — lembut, bumbu kacang khas, dan aroma meresap. Rekomendasi: saus ekstra dan lontong untuk experience maksimal.',
      'comments': []
    },
    {
      'account': 'bakso_juara',
      'profile': 'https://images.unsplash.com/photo-1532634896-26909d0d3a0e?w=200',
      'name': 'Bakso Juara',
      'image': 'https://images.unsplash.com/photo-1549576490-b0b4831ef60a?w=1400',
      'category': 'Street Food',
      'price': 'Rp15.000',
      'location': 'Malang',
      'rating': 4.4,
      'likes': 210,
      'saved': false,
      'liked': false,
      'caption':
          'Bakso kenyal, kuah gurih dengan sambal spesial. Porsi pas, harga ramah kantong — favorit mahasiswa dan keluarga.',
      'comments': []
    },
    {
      'account': 'pawon_gendut',
      'profile': 'https://images.unsplash.com/photo-1514518872867-1c0a2a2a7f1b?w=200',
      'name': 'Pawon Gendut',
      'image': 'https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?w=1400',
      'category': 'Restoran',
      'price': 'Rp55.000',
      'location': 'Bandung',
      'rating': 4.5,
      'likes': 180,
      'saved': false,
      'liked': false,
      'caption':
          'Masakan rumahan dengan porsi besar — ayam bakar madu & sop iga favorit keluarga. Atmosfer hangat, cocok untuk perayaan kecil.',
      'comments': []
    },
    {
      'account': 'dessert_corner',
      'profile': 'https://images.unsplash.com/photo-1526318472351-c75fcf070c98?w=200',
      'name': 'Dessert Corner',
      'image': 'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=1400',
      'category': 'Restoran',
      'price': 'Rp28.000',
      'location': 'Jakarta',
      'rating': 4.3,
      'likes': 90,
      'saved': true,
      'liked': false,
      'caption':
          'Dessert premium: cake, pastry & specialty drinks. Sempurna untuk kencan atau treat-yourself day.',
      'comments': []
    },
    {
      'account': 'mie_aceh_original',
      'profile': 'https://images.unsplash.com/photo-1521305916504-4a1121188589?w=200',
      'name': 'Mie Aceh Original',
      'image': 'https://images.unsplash.com/photo-1564758866814-3d5f1c9fb938?w=1400',
      'category': 'Street Food',
      'price': 'Rp25.000',
      'location': 'Banda Aceh',
      'rating': 4.7,
      'likes': 310,
      'saved': false,
      'liked': false,
      'caption':
          'Mie Aceh pedas gurih dengan rempah kuat. Porsi memuaskan, cocok buat penggemar pedas sejati.',
      'comments': []
    },
    {
      'account': 'kafetaria_univ',
      'profile': 'https://images.unsplash.com/photo-1549880338-65ddcdfd017b?w=200',
      'name': 'Kafetaria Kampus',
      'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=1400',
      'category': 'Caffe',
      'price': 'Rp18.000',
      'location': 'Bandung',
      'rating': 4.0,
      'likes': 60,
      'saved': false,
      'liked': false,
      'caption':
          'Tempat nongkrong ekonomis untuk mahasiswa — es kopi susu gula aren favorit banyak orang.',
      'comments': []
    },
    {
      'account': 'warteg_mama',
      'profile': 'https://images.unsplash.com/photo-1542444459-db6b1e7a4d3d?w=200',
      'name': 'Warteg Mama',
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=1400',
      'category': 'Restoran',
      'price': 'Rp12.000',
      'location': 'Semarang',
      'rating': 4.1,
      'likes': 75,
      'saved': false,
      'liked': false,
      'caption':
          'Masakan rumahan ala warteg dengan pilihan lauk lengkap. Pas untuk makan siang praktis dan kenyang.',
      'comments': []
    },
    {
      'account': 'nasi_uduk_hati',
      'profile': 'https://images.unsplash.com/photo-1549880338-65ddcdfd017b?w=201',
      'name': 'Nasi Uduk Hati',
      'image': 'https://images.unsplash.com/photo-1604908177522-0408c7a49e2b?w=1400',
      'category': 'Street Food',
      'price': 'Rp10.000',
      'location': 'Jakarta',
      'rating': 4.2,
      'likes': 95,
      'saved': false,
      'liked': false,
      'caption':
          'Nasi uduk harum dengan sambal dan lauk pilihan. Porsi kecil & pas untuk sarapan praktis.',
      'comments': []
    },
    {
      'account': 'sushi_kecil',
      'profile': 'https://images.unsplash.com/photo-1543779506-3c3b9c7a9e3b?w=200',
      'name': 'Sushi Kecil',
      'image': 'https://images.unsplash.com/photo-1544025162-d76694265947?w=1400',
      'category': 'Restoran',
      'price': 'Rp65.000',
      'location': 'Jakarta',
      'rating': 4.6,
      'likes': 210,
      'saved': false,
      'liked': false,
      'caption':
          'Sushi dengan bahan segar, presentasi cantik dan porsi pas. Menu pilihan untuk yang ingin sesuatu yang ringan dan premium.',
      'comments': []
    },
    {
      'account': 'bakmi_aji',
      'profile': 'https://images.unsplash.com/photo-1548199973-03cce0bbc87b?w=200',
      'name': 'Bakmi Aji',
      'image': 'https://images.unsplash.com/photo-1606756795816-9e0d9f1b3b32?w=1400',
      'category': 'Street Food',
      'price': 'Rp22.000',
      'location': 'Yogyakarta',
      'rating': 4.5,
      'likes': 140,
      'saved': false,
      'liked': false,
      'caption': 'Bakmi goreng khas Aji dengan topping lengkap — favorit mahasiswa & pekerja kantoran.',
      'comments': []
    },
    {
      'account': 'pondok_ikan_bakar',
      'profile': 'https://images.unsplash.com/photo-1516685018646-5498ad8ffb4a?w=200',
      'name': 'Pondok Ikan Bakar',
      'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=1400',
      'category': 'Restoran',
      'price': 'Rp75.000',
      'location': 'Makassar',
      'rating': 4.7,
      'likes': 260,
      'saved': false,
      'liked': false,
      'caption':
          'Ikan bakar segar, sambal khas, dan nasi hangat — suasana pinggir pantai kecil di kota besar. Rekomendasi: ikan kakap bakar madu.',
      'comments': []
    },
  ];

  // ====== Filtered getter ======
  List<Map<String, dynamic>> get filtered {
    final q = query.trim().toLowerCase();
    return posts.where((p) {
      final name = (p['name'] as String).toLowerCase();
      final location = (p['location'] as String).toLowerCase();
      final category = (p['category'] as String).toLowerCase();
      final matchesQuery = q.isEmpty || name.contains(q) || location.contains(q) || category.contains(q);
      final matchesFilter = selectedFilter == 'Semua' ||
          selectedFilter.toLowerCase() == category ||
          selectedFilter.toLowerCase() == location;
      return matchesQuery && matchesFilter;
    }).toList();
  }

  // ====== NAVIGATIONS & ACTIONS ======
Future<void> _openProfile(Map<String, dynamic> post, {bool isMyProfile = false}) async {
  // buka halaman profil tanpa mengubah tab index
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ProfileInfoPage(
        username: post['name'],
        isMyProfile: isMyProfile,
        postsRef: posts,
      ),
    ),
  );
}


  Future<void> _openDetail(Map<String, dynamic> post) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailPage(post: post)),
    );
    setState(() {});
  }

  Future<void> _openSavedPage() async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => SavedPostsPage(postsRef: posts)));
    setState(() {});
  }

  Future<void> _openSearch() async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => SearchPage(allPosts: posts)));
    setState(() {});
  }

  void _showFilterSheet() {
    final filters = [
      'Semua',
      'Warkop',
      'Restoran',
      'Caffe',
      'Street Food',
      'Jakarta',
      'Bandung',
      'Malang',
      'Surabaya',
      'Yogyakarta',
      'Banda Aceh'
    ];
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.whiteSoft,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: filters.map((f) {
              final active = f == selectedFilter;
              return ChoiceChip(
                label: Text(f),
                selected: active,
                selectedColor: AppColors.brownSoft,
                onSelected: (_) {
                  setState(() => selectedFilter = f);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // ====== Post menu: includes Report with popup confirmation ======
  void _showPostMenu(Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.whiteSoft,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(14))),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(post['saved'] ? Icons.bookmark_remove : Icons.bookmark, color: AppColors.brownMain),
                title: Text(post['saved'] ? 'Hapus dari Disimpan' : 'Simpan'),
                onTap: () {
                  setState(() => post['saved'] = !(post['saved'] as bool));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(post['saved'] ? 'Disimpan' : 'Dihapus dari simpanan')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.map_outlined),
                title: const Text('Buka di Google Maps'),
                onTap: () {
                  final mapsLink = 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(post['location'])}';
                  Clipboard.setData(ClipboardData(text: mapsLink));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link Google Maps disalin ke clipboard')));
                },
              ),
              ListTile(
                leading: const Icon(Icons.report, color: Colors.red),
                title: const Text('Laporkan'),
                onTap: () {
                  Navigator.pop(context);
                  _showReportDialog(post);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showReportDialog(Map<String, dynamic> post) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Laporkan Postingan'),
        content: Text('Apakah Anda yakin ingin melaporkan postingan "${post['name']}"? Tim kami akan meninjau laporan ini.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close confirmation
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Terima Kasih'),
                  content: const Text('Laporan telah diterima dan akan ditinjau.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
                  ],
                ),
              );
            },
            child: const Text('Laporkan'),
          ),
        ],
      ),
    );
  }

  // ====== Share dialog used on post actions ======
  void _showSharePostDialog(Map<String, dynamic> post) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Bagikan'),
        content: Text('Bagikan postingan "${post['name']}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          TextButton(
            onPressed: () {
              final link = 'https://jelajah-rasa.app/post/${post['account']}';
              Clipboard.setData(ClipboardData(text: link));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link postingan disalin ke clipboard')));
            },
            child: const Text('Bagikan'),
          ),
        ],
      ),
    );
  }

  // ====== UI ======
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.whiteSoft, // white top as requested
        elevation: 1,
        title: const Text('JelajahRasa', style: TextStyle(color: AppColors.brownDark, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_rounded, color: AppColors.brownDark),
            onPressed: _showFilterSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar (read-only, open search page on tap)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.whiteSoft,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.cream),
            ),
            child: TextField(
              readOnly: true,
              onTap: _openSearch,
              decoration: const InputDecoration(
                icon: Icon(Icons.search, color: AppColors.brownMain),
                hintText: 'Cari nama tempat, kategori, atau lokasi...',
                border: InputBorder.none,
              ),
            ),
          ),

          // Feed
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(milliseconds: 600));
                setState(() {});
              },
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 12),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final post = filtered[index];
                  return GestureDetector(
                    onTap: () => _openDetail(post),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.whiteSoft,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: AppColors.brownDark.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 6))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header - profile, name, location, menu
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            leading: GestureDetector(
                              onTap: () => _openProfile(post, isMyProfile: false),
                              child: CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(post['profile']),
                                backgroundColor: Colors.grey[200],
                                onBackgroundImageError: (_, __) {},
                              ),
                            ),
                            title: GestureDetector(
                              onTap: () => _openProfile(post, isMyProfile: false),
                              child: Text(post['name'], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.brownDark)),
                            ),
                            subtitle: Text(post['location'], style: const TextStyle(color: Colors.grey)),
                            trailing: IconButton(
                              icon: const Icon(Icons.more_vert, color: AppColors.brownDark),
                              onPressed: () => _showPostMenu(post),
                            ),
                          ),

                          // Image (errorBuilder shows placeholder - no broken image)
                          ClipRRect(
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                            child: Image.network(
                              post['image'],
                              height: 260,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return Container(height: 260, alignment: Alignment.center, child: CircularProgressIndicator(value: progress.expectedTotalBytes != null ? progress.cumulativeBytesLoaded / (progress.expectedTotalBytes ?? 1) : null));
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 260,
                                  color: Colors.grey[200],
                                  alignment: Alignment.center,
                                  child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.image_not_supported, size: 48, color: Colors.grey),
                                      SizedBox(height: 8),
                                      Text('Gagal memuat gambar', style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          // Caption & actions
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(post['caption'], style: const TextStyle(color: Colors.black87)),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              post['liked'] = !(post['liked'] as bool);
                                              post['likes'] += post['liked'] ? 1 : -1;
                                            });
                                          },
                                          icon: Icon(post['liked'] ? Icons.favorite : Icons.favorite_border, color: post['liked'] ? Colors.red : AppColors.brownDark),
                                        ),
                                        IconButton(
                                          onPressed: () => setState(() => post['saved'] = !(post['saved'] as bool)),
                                          icon: Icon(post['saved'] ? Icons.bookmark : Icons.bookmark_border, color: AppColors.brownDark),
                                        ),
                                        IconButton(
                                          onPressed: () => _showSharePostDialog(post),
                                          icon: const Icon(Icons.share, color: AppColors.brownDark),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.amber, size: 18),
                                        const SizedBox(width: 6),
                                        Text(post['rating'].toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

 bottomNavigationBar: BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: (i) async {
    if (i == 0) {
      // Tetap di beranda
      setState(() => _selectedIndex = 0);
    } else if (i == 1) {
      // Buka halaman posting
      await Navigator.push(context, MaterialPageRoute(builder: (_) => const PostingPage()));
    } else if (i == 2) {
      // Buka halaman tersimpan
      await _openSavedPage();
    } else if (i == 3) {
      // Buka profil sendiri dan ubah tab index ke 3
      setState(() => _selectedIndex = 3);
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfileInfoPage(
            username: 'Warung Nusantara',
            isMyProfile: true,
            postsRef: posts,
          ),
        ),
      );
    }
  },
  selectedItemColor: AppColors.brownDark,
  unselectedItemColor: Colors.grey,
  type: BottomNavigationBarType.fixed,
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
    BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: 'Posting'),
    BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Simpan'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
  ],
),


    );
  }
}
