import 'package:flutter/material.dart';
import '../theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameC = TextEditingController();
  final _passwordC = TextEditingController();
  bool _loading = false;

  Future<void> _login() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() => _loading = false);
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void dispose() {
    _usernameC.dispose();
    _passwordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppColors.whiteSoft,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [BoxShadow(color: AppColors.brownDark.withOpacity(0.06), blurRadius: 18, offset: const Offset(0, 8))],
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.restaurant_menu_rounded, size: 72, color: AppColors.brownSoft),
              const SizedBox(height: 12),
              const Text('JelajahRasa', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.brownDark)),
              const SizedBox(height: 18),
              TextField(controller: _usernameC, decoration: InputDecoration(labelText: 'Username', prefixIcon: const Icon(Icons.person_outline, color: AppColors.brownMain), filled: true, fillColor: AppColors.cream, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none))),
              const SizedBox(height: 12),
              TextField(controller: _passwordC, obscureText: true, decoration: InputDecoration(labelText: 'Password', prefixIcon: const Icon(Icons.lock_outline, color: AppColors.brownMain), filled: true, fillColor: AppColors.cream, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none))),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _login,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), backgroundColor: AppColors.brownSoft, elevation: 0),
                  child: _loading ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Masuk', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.brownDark)),
                ),
              ),
              const SizedBox(height: 14),
              Text('Masuk tanpa batas rasa 🍜', style: TextStyle(color: AppColors.brownDark.withOpacity(0.8))),
              const SizedBox(height: 8),
            ]),
          ),
        ),
      ),
    );
  }
}