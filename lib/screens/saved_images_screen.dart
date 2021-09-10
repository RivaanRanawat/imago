import "package:flutter/material.dart";
import 'package:imago/models/photo.dart';
import 'package:imago/utils/image_functions.dart';
import 'package:imago/utils/sqfl_db_helper.dart';
import 'package:imago/widgets/display_saved_images.dart';

class SavedImages extends StatefulWidget {
  const SavedImages({Key key}) : super(key: key);

  @override
  _SavedImagesState createState() => _SavedImagesState();
}

class _SavedImagesState extends State<SavedImages> {
  Image image;
  DBHelper dbHelper;
  List<Photo> images;

  @override
  void initState() {
    super.initState();
    images = [];
    dbHelper = DBHelper();
    refreshImages();
  }

  refreshImages() {
    dbHelper.getPhotos().then((imgs) {
      setState(() {
        images.clear();
        images.addAll(imgs);
      });
    });
  }

  gridView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: images.map((photo) {
          return InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DisplaySavedImages(photo.photoName))),
            child: Hero(
              tag: photo.photoName,
              child: Utility.imageFromBase64String(photo.photoName),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text("Your Images", style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: gridView(context),
            )
          ],
        ),
      ),
    );
  }
}
