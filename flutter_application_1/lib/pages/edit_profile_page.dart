import 'package:flutter/material.dart';
import '../theme.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String category;
  final String description;
  final String location;
  final String mapsLink;

  const EditProfilePage({super.key, this.name = '', this.category = '', this.description = '', this.location = '', this.mapsLink = ''});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameC;
  late TextEditingController _catC;
  late TextEditingController _descC;
  late TextEditingController _locC;
  late TextEditingController _mapsC;

  @override
  void initState() {
    super.initState();
    _nameC = TextEditingController(text: widget.name);
    _catC = TextEditingController(text: widget.category);
    _descC = TextEditingController(text: widget.description);
    _locC = TextEditingController(text: widget.location);
    _mapsC = TextEditingController(text: widget.mapsLink);
  }

  @override
  void dispose() {
    _nameC.dispose();
    _catC.dispose();
    _descC.dispose();
    _locC.dispose();
    _mapsC.dispose();
    super.dispose();
  }

  void _save() {
    Navigator.pop(context, {
      'name': _nameC.text.trim(),
      'category': _catC.text.trim(),
      'description': _descC.text.trim(),
      'location': _locC.text.trim(),
      'mapsLink': _mapsC.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil', style: TextStyle(color: AppColors.brownDark)), backgroundColor: AppColors.whiteSoft),
      body: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
        TextField(controller: _nameC, decoration: InputDecoration(labelText: 'Nama Tempat', filled: true, fillColor: AppColors.cream, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cream)))),
        const SizedBox(height: 12),
        TextField(controller: _catC, decoration: InputDecoration(labelText: 'Kategori', filled: true, fillColor: AppColors.cream, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cream)))),
        const SizedBox(height: 12),
        TextField(controller: _descC, maxLines: 4, decoration: InputDecoration(labelText: 'Deskripsi', filled: true, fillColor: AppColors.cream, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cream)))),
        const SizedBox(height: 12),
        TextField(controller: _locC, decoration: InputDecoration(labelText: 'Alamat / Lokasi', filled: true, fillColor: AppColors.cream, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cream)))),
        const SizedBox(height: 12),
        TextField(controller: _mapsC, decoration: InputDecoration(labelText: 'Link Google Maps', filled: true, fillColor: AppColors.cream, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.cream)))),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, child: OutlinedButton(onPressed: _save, style: OutlinedButton.styleFrom(backgroundColor: AppColors.cream, side: const BorderSide(color: Color(0xFFDDB892))), child: const Text('Simpan Perubahan', style: TextStyle(color: AppColors.linkBlue)))),
      ])),
    );
  }
}