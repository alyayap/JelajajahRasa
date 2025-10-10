import 'package:flutter/material.dart';
import 'theme.dart';
import 'pages/splash_page.dart';
import 'pages/loginpage.dart';
import 'pages/home_feed.dart';
import 'pages/profileinfo_page.dart';
import 'pages/edit_profile_page.dart';
import 'pages/saved_posts_page.dart';
import 'pages/menu_detail_page.dart';
import 'pages/search_page.dart';
import 'pages/posting_page.dart';
import 'pages/detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyPosts = [
      {
        'account': 'dummy_account',
        'profile': 'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=200',
        'name': 'Contoh Tempat',
        'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=1000',
        'category': 'Warkop',
        'price': 'Rp12.000',
        'location': 'Malang',
        'rating': 4.5,
        'likes': 120,
        'saved': false,
        'liked': false,
        'caption': 'Ini contoh caption untuk testing halaman detail.',
        'comments': [],
      },
    ];

    return MaterialApp(
      title: 'JelajahRasa',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/home': (_) => const HomeFeed(),
        '/profile': (_) =>
            const ProfileInfoPage(username: 'Resto Nusantara'),
        '/edit-profile': (_) => const EditProfilePage(),
        '/saved': (_) => SavedPostsPage(postsRef: dummyPosts),
        '/menu-detail': (_) => const MenuDetailPage(),
        '/search': (_) => SearchPage(allPosts: dummyPosts),
        '/posting': (_) => const PostingPage(),
        '/detail': (_) => DetailPage(post: dummyPosts.first),
      },
    );
  }
}
