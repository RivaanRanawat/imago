import 'package:flutter/material.dart';
import 'package:image_editor_pro/image_editor_pro.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class EditImageScreen extends StatefulWidget {
  const EditImageScreen({ Key key }) : super(key: key);

  @override
  _EditImageScreenState createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  Future<void> getimageditor() =>
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
            getimageditor();
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