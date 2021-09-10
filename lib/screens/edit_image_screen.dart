import 'package:flutter/material.dart';
import 'package:image_editor_pro/image_editor_pro.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:imago/models/photo.dart';
import 'package:imago/utils/image_functions.dart';
import 'package:imago/utils/sqfl_db_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class EditImageScreen extends StatefulWidget {
  const EditImageScreen({Key key}) : super(key: key);

  @override
  _EditImageScreenState createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  DBHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }

  Future<void> getimageditor(BuildContext context) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ImageEditorPro(
          appBarColor: Colors.black87,
          bottomBarColor: Colors.black87,
          pathSave: null,
          pixelRatio: 10,
        );
      })).then((geteditimage) {
        if (geteditimage != null) {
          _requestPermission(Permission.storage).then((value) {
            ImageGallerySaver.saveFile(geteditimage.path).then((value) {
              String imgString =
                  Utility.base64String(geteditimage.readAsBytesSync());
              Photo photo = Photo(0, imgString);
              dbHelper.save(photo).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Image Saved to Gallery"),
                ));
              });
              print(value);
            }).catchError((err) => print(err));
          }).catchError((err) => print(err));
        }
      }).catchError((er) {
        print(er);
      });

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text("Open Editor"),
          onPressed: () {
            getimageditor(context);
          },
        ),
      ),
      appBar: AppBar(
        title: Text('Image Editor Pro example',
            style: TextStyle(color: Colors.white)),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
    );
  }
}
