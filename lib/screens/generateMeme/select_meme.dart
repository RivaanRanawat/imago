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
      print('already greanted');
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
        title: Text("Select Meme", style: TextStyle(color: Colors.black),),
      );
}
