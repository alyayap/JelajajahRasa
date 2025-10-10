import 'package:flutter/material.dart';
import '../theme.dart';
import 'edit_profile_page.dart';
import 'menu_detail_page.dart';
import 'saved_posts_page.dart';
import 'package:flutter/services.dart';

class ProfileInfoPage extends StatefulWidget {
  final String username;
  final bool isMyProfile;
  final List<Map<String, dynamic>>? postsRef;

  const ProfileInfoPage({
    super.key,
    required this.username,
    this.isMyProfile = false,
    this.postsRef,
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

  int followers = 1342;
  int following = 278;

  final List<Map<String, String>> gallery = List.generate(
    12,
    (i) => {
      'image':
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=1000'
    },
  );

  List<Map<String, String>> menu = [
    {
      'name': 'Kopi Tubruk',
      'price': 'Rp12.000',
      'img':
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600',
      'desc': 'Kopi tubruk gula jawa.'
    },
    {
      'name': 'Nasi Goreng Spesial',
      'price': 'Rp28.000',
      'img':
          'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?w=600',
      'desc': 'Nasi goreng ala rumah.'
    },
    {
      'name': 'Sate Madura',
      'price': 'Rp20.000',
      'img': 'https://images.unsplash.com/photo-1546069901-eacef0df6022?w=600',
      'desc': 'Sate ayam bumbu kacang.'
    },
    {
      'name': 'Pisang Goreng',
      'price': 'Rp6.000',
      'img':
          'https://images.unsplash.com/photo-1606756795816-9e0d9f1b3b32?w=600',
      'desc': 'Pisang goreng garing.'
    },
    {
      'name': 'Es Teh Manis',
      'price': 'Rp5.000',
      'img':
          'https://images.unsplash.com/photo-1501630834273-4b5604d2ee31?w=600',
      'desc': 'Es teh segar.'
    },
  ];

  final List<Map<String, String>> reviews = [
    {
      'user': 'ani_traveler',
      'text': 'Tempat nyaman, harga terjangkau.',
      'media': '',
      'time': '1d',
      'rating': '4'
    },
    {
      'user': 'andi_food',
      'text': 'Rasa enak, pelayanan ramah.',
      'media': 'https://images.unsplash.com/photo-1546069901-eacef0df6022?w=600',
      'time': '2d',
      'rating': '5'
    },
    {
      'user': 'nina_cafe',
      'text': 'Suasananya cozy banget!',
      'media': '',
      'time': '3d',
      'rating': '5'
    },
  ];

  @override
  void initState() {
    super.initState();
    placeName = widget.username;
    category = 'Warkop';
    description =
        'Kedai kecil dengan suasana hangat — kopi enak, roti bakar rumah, cocok untuk kumpul santai. Kami bangga menyajikan bahan lokal berkualitas setiap hari. Nikmati ambience yang ramah dan menu tradisional dengan sentuhan modern.';
    location = 'Jl. Contoh No.1, Malang';
    mapsLink =
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(location)}';
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
        placeName = result['name']!;
        category = result['category']!;
        description = result['description']!;
        location = result['location']!;
        mapsLink = result['mapsLink']!;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Profil diperbarui')));
    }
  }

  void _shareProfile() {
    Clipboard.setData(ClipboardData(
        text:
            'https://jelajah-rasa.app/place/${placeName.replaceAll(' ', '-').toLowerCase()}'));
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Bagikan'),
        content: const Text('Link profil disalin ke clipboard'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
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
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK')),
        ],
      ),
    );
  }

  void _openMenuDetail(Map<String, String> item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MenuDetailPage(item: item)),
    );
  }

  void _openSaved() async {
    if (widget.postsRef == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data posting tidak tersedia')),
      );
      return;
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: Text(
          placeName,
          style: const TextStyle(color: AppColors.brownDark),
        ),
        backgroundColor: AppColors.whiteSoft,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            const CircleAvatar(
              radius: 56,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=300'),
            ),
            const SizedBox(height: 10),
            Text(
              placeName,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brownDark),
            ),
            const SizedBox(height: 6),
            Text(
              '$category • $location',
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 12),

            // Followers & Following
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      '$followers',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Text(
                      'Followers',
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(width: 30),
                Column(
                  children: [
                    Text(
                      '$following',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Text(
                      'Following',
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: _editProfile,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.cream,
                    side: const BorderSide(color: Color(0xFFDDB892)),
                  ),
                  child: const Text(
                    'Edit Profil',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _shareProfile,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brownSoft),
                  child: const Text('Bagikan'),
                )
              ],
            ),

            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 6),
                      Text(
                        averageRating.toStringAsFixed(1),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
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
            ListTile(
              leading:
                  const Icon(Icons.map_outlined, color: AppColors.brownMain),
              title: const Text('Buka di Google Maps'),
              subtitle: Text(location),
              onTap: _openMaps,
            ),
            const Divider(),
            const SizedBox(height: 6),

            // Tab Section
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    indicatorColor: AppColors.brownSoft,
                    labelColor: AppColors.brownDark,
                    tabs: [
                      Tab(icon: Icon(Icons.grid_on), text: 'Postingan'),
                      Tab(icon: Icon(Icons.comment), text: 'Ulasan'),
                      Tab(icon: Icon(Icons.menu_book), text: 'Daftar Menu'),
                    ],
                  ),
                  SizedBox(
                    height: 400,
                    child: TabBarView(
                      children: [
                        // Postingan
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 6,
                            children: gallery
                                .map(
                                  (g) => ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      g['image']!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        color: Colors.grey[200],
                                        child: const Icon(Icons.broken_image),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),

                        // Ulasan
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.separated(
                            itemCount: reviews.length,
                            separatorBuilder: (_, __) => const Divider(),
                            itemBuilder: (context, i) {
                              final r = reviews[i];
                              return ListTile(
                                leading: const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200'),
                                ),
                                title: Text(
                                  r['user']!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(r['text']!),
                                    const SizedBox(height: 6),
                                    if (r['media'] != null &&
                                        r['media']!.isNotEmpty)
                                      GestureDetector(
                                        onTap: () {
                                          final media = r['media']!;
                                          if (media.endsWith('.mp4')) {
                                            Clipboard.setData(
                                                ClipboardData(text: media));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Link video disalin')));
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (_) => Dialog(
                                                child: Image.network(
                                                  media,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (_, __, ___) =>
                                                      const SizedBox(
                                                    height: 200,
                                                    child: Center(
                                                      child: Icon(
                                                          Icons.broken_image),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 6),
                                          width: 120,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.grey[200],
                                          ),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  r['media']!,
                                                  width: double.infinity,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              if (r['media']!.endsWith('.mp4'))
                                                const Icon(
                                                  Icons.play_circle_outline,
                                                  size: 34,
                                                  color: Colors.white,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                trailing: Text(r['time'] ?? ''),
                              );
                            },
                          ),
                        ),

                        // Menu
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: menu.length,
                            itemBuilder: (context, i) {
                              final m = menu[i];
                              return ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    m['img']!,
                                    width: 58,
                                    height: 58,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.broken_image),
                                    ),
                                  ),
                                ),
                                title: Text(m['name']!),
                                subtitle: Text(m['price']!),
                                trailing: ElevatedButton(
                                  onPressed: () => _openMenuDetail(m),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.brownSoft),
                                  child: const Text('Lihat'),
                                ),
                              );
                            },
                          ),
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
          if (i == 0) {
            Navigator.pop(context);
          } else if (i == 1) {
            Navigator.pushNamed(context, '/posting');
          } else if (i == 2) {
            _openSaved();
          }
        },
        selectedItemColor: AppColors.brownDark,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: 'Posting'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: 'Simpan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
