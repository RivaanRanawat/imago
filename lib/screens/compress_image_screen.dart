import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imago/home_screen.dart';
import 'package:imago/models/photo.dart';
import 'package:imago/utils/image_functions.dart';
import 'package:imago/utils/repeated_functions.dart';
import 'package:imago/utils/sqfl_db_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class CompressImageScreen extends StatefulWidget {
  const CompressImageScreen({Key key}) : super(key: key);

  @override
  _CompressImageScreenState createState() => _CompressImageScreenState();
}

class _CompressImageScreenState extends State<CompressImageScreen> {
  File imageFile;
  File newImage;
  double _value = 5;
  DBHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }

  Future<File> compressFile(File file, int value) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: value,
    );
    print(file.lengthSync());
    print(result.lengthSync());
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Compress Image",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (imageFile != null) {
                requestPermission(Permission.storage).then((value) {
                  ImageGallerySaver.saveFile(newImage.path).then((value) {
                    String imgString =
                        Utility.base64String(newImage.readAsBytesSync());
                    Photo photo = Photo(0, imgString);
                    dbHelper.save(photo).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Image Saved to Gallery"),
                      ));
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    });
                  }).catchError((err) => print(err));
                }).catchError((err) => print(err));
              }
            },
            child: Text(
              "Save",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageFile != null
              ? Row(
                  children: [
                    imageFile != null
                        ? Container(
                            child: Image.file(imageFile),
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width * 0.49,
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Center(
                              child: Text(
                                "Please select an image",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                          ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    newImage != null
                        ? Container(
                            child: Image.file(newImage),
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width * 0.49,
                          )
                        : Container()
                  ],
                )
              : Center(
                  child: Text(
                    "Please select an image",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final pickedImage =
                await ImagePicker().getImage(source: ImageSource.gallery);
            setState(() {
              imageFile = pickedImage != null ? File(pickedImage.path) : null;
            });
            if (imageFile != null) {
              try {
                File img = await compressFile(imageFile, _value.toInt());
                setState(() {
                  newImage = img;
                });
                print(newImage);
              } catch (err) {
                print(err);
              }
            }
          },
          child: Icon(Icons.add_a_photo)),
    );
  }
}
