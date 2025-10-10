import 'package:flutter/material.dart';
import '../theme.dart';

class PostingPage extends StatefulWidget {
  const PostingPage({Key? key}) : super(key: key);
  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  final TextEditingController _captionController = TextEditingController();
  String selectedImage = 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=700';
  final List<String> dummyImages = [
    'https://images.unsplash.com/photo-1543353071-087092ec393a?w=700',
    'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?w=700',
    'https://images.unsplash.com/photo-1565958011705-44e211f07c23?w=700',
    'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=700',
    'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=700',
    'https://images.unsplash.com/photo-1576866209830-5b4c1b69f985?w=700',
    'https://images.unsplash.com/photo-1606788075761-7a6a2e66c9d2?w=700',
    'https://images.unsplash.com/photo-1590080875831-a8a3686b8577?w=700',
    'https://images.unsplash.com/photo-1604908177522-0408c7a49e2b?w=700',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(backgroundColor: AppColors.whiteSoft, iconTheme: const IconThemeData(color: AppColors.brownDark), title: const Text('Buat Postingan', style: TextStyle(color: AppColors.brownDark, fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.network(selectedImage, height: 250, width: double.infinity, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(height: 250, color: Colors.grey[300], child: const Icon(Icons.broken_image, size: 60, color: AppColors.brownDark))))),
          const SizedBox(height: 20),
          TextField(controller: _captionController, maxLines: 3, decoration: const InputDecoration(labelText: 'Tulis caption...', border: OutlineInputBorder(), alignLabelWithHint: true)),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: AppColors.brownMain, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: () { if (_captionController.text.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tulis caption terlebih dahulu!'))); return; } ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Posting berhasil! 🎉'))); Navigator.pop(context); }, icon: const Icon(Icons.send, color: Colors.white), label: const Text('Posting', style: TextStyle(color: Colors.white, fontSize: 16)))),
          const SizedBox(height: 30),
          const Text('Pilih Foto dari Galeri', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.brownDark, fontSize: 16)),
          const SizedBox(height: 10),
          GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: dummyImages.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8), itemBuilder: (context, index) {
            final isSelected = dummyImages[index] == selectedImage;
            return GestureDetector(onTap: () { setState(() { selectedImage = dummyImages[index]; }); }, child: Stack(fit: StackFit.expand, children: [
              ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(dummyImages[index], fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300], child: const Icon(Icons.broken_image, color: AppColors.brownDark)))),
              if (isSelected) Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.brownDark, width: 3))),
            ]));
          }),
        ])),
      ),
    );
  }
}