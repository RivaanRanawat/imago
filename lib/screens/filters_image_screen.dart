import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:imago/home_screen.dart';
import 'package:imago/utils/repeated_functions.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';

class FiltersImageScreen extends StatefulWidget {
  @override
  _FiltersImageScreenState createState() => new _FiltersImageScreenState();
}

class _FiltersImageScreenState extends State<FiltersImageScreen> {
  String fileName;
  List<Filter> filters = presetFiltersList;
  final picker = ImagePicker();
  File imageFile;

  Future getImage(context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = new File(pickedFile.path);
      fileName = basename(imageFile.path);
      var image = imageLib.decodeImage(await imageFile.readAsBytes());
      image = imageLib.copyResize(image, width: 600);
      Map imagefile = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new PhotoFilterSelector(
            appBarColor: Colors.deepOrange,
            title: Text("Photo Filters"),
            image: image,
            filters: presetFiltersList,
            filename: fileName,
            loader: Center(child: CircularProgressIndicator()),
            fit: BoxFit.contain,
          ),
        ),
      );

      if (imagefile != null && imagefile.containsKey('image_filtered')) {
        setState(() {
          imageFile = imagefile['image_filtered'];
        });
        print(imageFile.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: new Text(
          'Photo Filters',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          imageFile != null
              ? IconButton(
                  onPressed: () {
                    requestPermission(Permission.storage).then((value) {
                      ImageGallerySaver.saveFile(imageFile.path).then((value) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      }).catchError((err) => print(err));
                    }).catchError((err) => print(err));
                  },
                  icon: Icon(Icons.save),
                  color: Colors.black,
                )
              : Container()
        ],
      ),
      body: Center(
        child: new Container(
          child: imageFile == null
              ? Center(
                  child: new Text(
                    'Please select an image.',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                )
              : Image.file(new File(imageFile.path)),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => getImage(context),
        tooltip: 'Pick Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}
