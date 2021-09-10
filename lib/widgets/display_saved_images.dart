import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:imago/home_screen.dart';
import 'package:imago/utils/image_functions.dart';
import 'package:imago/utils/repeated_functions.dart';
import 'package:permission_handler/permission_handler.dart';

class DisplaySavedImages extends StatelessWidget {
  final String image;
  const DisplaySavedImages(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Your Photo",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.black),
            onPressed: () {
              requestPermission(Permission.storage).then(
                (value) {
                  ImageGallerySaver.saveImage(
                      Utility.dataFromBase64String(image));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Image Saved to Gallery"),
                  ));
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Hero(
          tag: image,
          child: Utility.imageFromBase64String(image),
        ),
      ),
    );
  }
}
