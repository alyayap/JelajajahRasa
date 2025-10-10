import 'package:flutter/material.dart';
import '../theme.dart';
import 'home_feed.dart';
import 'explore_page.dart';
import 'posting_page.dart';
import 'profile_page.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});
  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;

  // Navigasi langsung ke Home setelah posting
  void goToHome() => setState(() => pageIndex = 0);

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeFeed(),
      const ExplorePage(),
      const PostingPage(), 
      const ProfileInfoPage(username: '',),
    ];

    final titles = ['Feed', 'Explore', 'Posting', 'Profile'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[pageIndex],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: pages[pageIndex],

      bottomNavigationBar: Container(
        height: 64,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          border: Border(
            top: BorderSide(color: Colors.black12, width: 0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_filled, 0),
            _buildNavItem(Icons.search, 1),
            _buildAddButton(2),
            _buildNavItem(Icons.person, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = pageIndex == index;
    return GestureDetector(
      onTap: () => setState(() => pageIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
          ),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.primary : Colors.white,
          size: 26,
        ),
      ),
    );
  }

  Widget _buildAddButton(int index) {
    final isSelected = pageIndex == index;
    return GestureDetector(
      onTap: () => setState(() => pageIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white),
        ),
        child: Icon(
          Icons.add,
          color: isSelected ? AppColors.primary : Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
