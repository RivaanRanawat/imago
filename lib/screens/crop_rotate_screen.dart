import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imago/home_screen.dart';
import 'package:imago/models/photo.dart';
import 'package:imago/utils/image_functions.dart';
import 'package:imago/utils/repeated_functions.dart';
import 'package:imago/utils/sqfl_db_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class CropRotateScreen extends StatefulWidget {
  @override
  _CropRotateScreenState createState() => _CropRotateScreenState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _CropRotateScreenState extends State<CropRotateScreen> {
  AppState state;
  File imageFile;
  DBHelper dbHelper;

  @override
  void initState() {
    super.initState();
    state = AppState.free;
    dbHelper = DBHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Crop And Rotate",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          state == AppState.cropped
              ? IconButton(
                  onPressed: () {
                    requestPermission(Permission.storage).then((value) {
                      ImageGallerySaver.saveFile(imageFile.path).then((value) {
                        String imgString =
                            Utility.base64String(imageFile.readAsBytesSync());
                        Photo photo = Photo(0, imgString);
                        dbHelper.save(photo).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Image Saved to Gallery"),
                          ));
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        });
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
        child: imageFile != null
            ? Image.file(imageFile)
            : Center(
                child: Text(
                  "Please select an image",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () {
          if (state == AppState.free)
            _pickImage();
          else if (state == AppState.picked)
            _cropImage();
          else if (state == AppState.cropped) _clearImage();
        },
        child: _buildButtonIcon(),
      ),
    );
  }

  Widget _buildButtonIcon() {
    if (state == AppState.free)
      return Icon(Icons.add);
    else if (state == AppState.picked)
      return Icon(Icons.crop);
    else if (state == AppState.cropped)
      return Icon(Icons.clear);
    else
      return Container();
  }

  Future<Null> _pickImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
      _cropImage();
    }
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }
}
