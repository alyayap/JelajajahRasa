import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../theme.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String category;
  final String description;
  final String location;
  final String mapsLink;

  const EditProfilePage({
    super.key,
    this.name = '',
    this.category = '',
    this.description = '',
    this.location = '',
    this.mapsLink = '',
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameC;
  late TextEditingController _catC;
  late TextEditingController _descC;
  late TextEditingController _locC;
  late TextEditingController _mapsC;

  File? _imageFile;

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

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: source,
      imageQuality: 70,
    );

    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  void _save() {
    Navigator.pop(context, {
      'name': _nameC.text.trim(),
      'category': _catC.text.trim(),
      'description': _descC.text.trim(),
      'location': _locC.text.trim(),
      'mapsLink': _mapsC.text.trim(),
      'imageFile': _imageFile?.path, // ⬅️ INI PENTING
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const Text(
          'Edit Profil',
          style: TextStyle(color: AppColors.brownDark),
        ),
        backgroundColor: AppColors.whiteSoft,
        iconTheme: const IconThemeData(color: AppColors.brownDark),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ===== FOTO PROFIL =====
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text('Pilih dari Galeri'),
                          onTap: () {
                            Navigator.pop(context);
                            _pickImage(ImageSource.gallery);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text('Ambil dari Kamera'),
                          onTap: () {
                            Navigator.pop(context);
                            _pickImage(ImageSource.camera);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 56,
                backgroundImage:
                    _imageFile != null ? FileImage(_imageFile!) : null,
                backgroundColor: Colors.grey[300],
                child: _imageFile == null
                    ? const Icon(Icons.camera_alt, size: 32)
                    : null,
              ),
            ),

            const SizedBox(height: 20),

            _field(_nameC, 'Nama Tempat'),
            _field(_catC, 'Kategori'),
            _field(_descC, 'Deskripsi', maxLines: 3),
            _field(_locC, 'Alamat / Lokasi'),
            _field(_mapsC, 'Link Google Maps'),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brownSoft,
                ),
                child: const Text('Simpan Perubahan'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController c,
    String label, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: AppColors.whiteSoft,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
