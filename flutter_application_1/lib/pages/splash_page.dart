import 'dart:async';
import 'package:flutter/material.dart';
import '../theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brownMain,
      body: FadeTransition(
        opacity: _fade,
        child: const Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.restaurant_menu, size: 110, color: Colors.white),
            SizedBox(height: 18),
            Text('JelajahRasa', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
            SizedBox(height: 8),
            Text('Temukan cita rasa lokal di genggamanmu 🍽️', style: TextStyle(color: Colors.white70, fontSize: 14)),
          ]),
        ),
      ),
    );
  }
}