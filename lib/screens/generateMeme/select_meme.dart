import 'package:flutter/material.dart';
import 'package:imago/widgets/memeWidgets/meme_templates.dart';
import 'package:permission_handler/permission_handler.dart';

class SelectMeme extends StatefulWidget {
  @override
  _SelectMemeState createState() => _SelectMemeState();
}

class _SelectMemeState extends State<SelectMeme> {
  int currentIndex = 0;

  askStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      print('already granted');
    }
  }

  List<Widget> widgets = [
    MemeTemplates(memes: [
      'assets/memes/meme-1.jpg',
      'assets/memes/meme-2.jpeg',
      'assets/memes/meme-3.jpg',
      'assets/memes/meme-4.jpg',
      'assets/memes/meme-5.webp',
      'assets/memes/meme-6.jpg',
      'assets/memes/meme-7.jpg',
      'assets/memes/meme-8.webp',
      'assets/memes/meme-9.png',
      'assets/memes/meme-10.jpg',
      "assets/memes/meme-11.jpg",
      "assets/memes/meme-12.png",
      "assets/memes/meme-13.jpg",
      "assets/memes/meme-14.jpg",
      "assets/memes/meme-16.jpg",
      "assets/memes/meme-15.png",
      "assets/memes/meme-17.jpg",
      "assets/memes/meme-18.jpg",
      "assets/memes/meme-19.png",
      "assets/memes/meme-20.jpg",
      "assets/memes/meme-21.jpg",
      "assets/memes/meme-22.png",
      "assets/memes/meme-23.jpg",
      "assets/memes/meme-24.png",
      "assets/memes/meme-25.jpg",
      "assets/memes/meme-26.jpg",
      "assets/memes/meme-27.jpg",
      "assets/memes/meme-28.jpg",
      "assets/memes/meme-29.png",
      "assets/memes/meme-30.jpg",
      "assets/memes/meme-31.jpg",
      "assets/memes/meme-32.jpg",
      "assets/memes/meme-33.jpg",
      "assets/memes/meme-34.png",
      "assets/memes/meme-35.jpg",
      "assets/memes/meme-36.jpg",
      "assets/memes/meme-37.jpg",
      "assets/memes/meme-38.jpg",
      "assets/memes/meme-39.jpg",
      "assets/memes/meme-40.jpg",
      "assets/memes/meme-41.jpg",
      "assets/memes/meme-42.jpg",
      "assets/memes/meme-43.jpg",
      "assets/memes/meme-44.jpg",
      "assets/memes/meme-45.jpg",
      "assets/memes/meme-46.jpg",
      "assets/memes/meme-47.jpg",
      "assets/memes/meme-48.png",
      "assets/memes/meme-49.jpeg",
      "assets/memes/meme-50.jpeg",
      "assets/memes/meme-51.jpg",
      "assets/memes/meme-52.jpg",
      "assets/memes/meme-53.png",
      "assets/memes/meme-54.jpg",
      "assets/memes/meme-56.jpg",
      "assets/memes/meme-56.jpg",
      "assets/memes/meme-55.jpeg",
      "assets/memes/meme-55.jpeg",
      "assets/memes/meme-57.jpg",
      "assets/memes/meme-58.jpg",
      "assets/memes/meme-59.jpg",
      "assets/memes/meme-60.jpg",
      "assets/memes/meme-61.jpg",
      "assets/memes/meme-62.jpg",
      "assets/memes/meme-63.png",
      "assets/memes/meme-64.jpg",
      "assets/memes/meme-65.jpg",
      "assets/memes/meme-66.jpg",
      "assets/memes/meme-67.jpg",
      "assets/memes/meme-68.jpg",
      "assets/memes/meme-69.jpg",
      "assets/memes/meme-70.jpeg",
      "assets/memes/meme-71.png",
      "assets/memes/meme-72.jpg",
      "assets/memes/meme-73.jpg",
      "assets/memes/meme-74.jpg",
      "assets/memes/meme-75.jpg",
      "assets/memes/meme-76.jpg",
      "assets/memes/meme-77.jpg",
      "assets/memes/meme-78.jpg",
      "assets/memes/meme-79.jpg",
      "assets/memes/meme-80.png",
      "assets/memes/meme-81.jpg",
      "assets/memes/meme-82.jpg",
      "assets/memes/meme-83.jpg",
      "assets/memes/meme-84.jpg",
      "assets/memes/meme-85.png",
      "assets/memes/meme-86.jpg",
      "assets/memes/meme-87.jpg",
      "assets/memes/meme-88.png",
      "assets/memes/meme-89.jpg",
      "assets/memes/meme-90.jpg",
      "assets/memes/meme-91.jpg",
      "assets/memes/meme-92.png",
      "assets/memes/meme-93.jpg",
      "assets/memes/meme-94.png",
      "assets/memes/meme-95.png",
      "assets/memes/meme-96.png",
      "assets/memes/meme-97.png",
      "assets/memes/meme-98.png",
      "assets/memes/meme-99.jpeg",
      "assets/memes/meme-100.jpeg",
      "assets/memes/meme-101.jpg"
    ]),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      askStoragePermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: widgets[currentIndex],
    );
  }

  Widget get _appBar => AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Select Meme",
          style: TextStyle(color: Colors.black),
        ),
      );
}
