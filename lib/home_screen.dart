import 'package:flutter/material.dart';
import 'package:image_editor_pro/image_editor_pro.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:imago/screens/edit_image_screen.dart';
import 'package:imago/widgets/build_card.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text("Imago", style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          primary: false,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 4.0,
          shrinkWrap: true,
          children: <Widget>[
            buildCard(
              Icons.camera_alt,
              "Edit Image",
              EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 20.0),
              () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ImageEditorPro(
                  appBarColor: Colors.black,
                  bottomBarColor: Colors.black,
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
              }),
            ),
            buildCard(Icons.calendar_view_month, "Create Collage",
                EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 20.0), () {}),
            buildCard(Icons.remove, "Remove Background",
                EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 20.0), () {}),
            buildCard(Icons.image, "Generate Meme",
                EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 20.0), () {}),
          ],
        ),
      ),
    );
  }
}
