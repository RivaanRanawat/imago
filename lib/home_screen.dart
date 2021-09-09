import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:image_editor_pro/image_editor_pro.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:imago/screens/compress_image_screen.dart';
import 'package:imago/screens/crop_rotate_screen.dart';
import 'package:imago/screens/filters_image_screen.dart';
import 'package:imago/screens/generateMeme/select_meme.dart';
import 'package:imago/utils/repeated_functions.dart';
import 'package:imago/widgets/build_card.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text("Imago - The Photo App",
            style: TextStyle(color: Colors.black)),
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
                () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ImageEditorPro(
                        appBarColor: Colors.black,
                        bottomBarColor: Colors.black,
                        pathSave: null,
                        pixelRatio: 10,
                      );
                    })).then((geteditimage) {
                      if (geteditimage != null) {
                        requestPermission(Permission.storage).then((value) {
                          ImageGallerySaver.saveFile(geteditimage.path)
                              .then((value) {
                            print(value);
                          }).catchError((err) => print(err));
                        }).catchError((err) => print(err));
                      }
                    }).catchError((er) {
                      print(er);
                    }),
                FlutterGradients.riverCity()),
            buildCard(
                Icons.filter_sharp,
                "Photo Filters",
                EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 20.0),
                () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FiltersImageScreen())),
                FlutterGradients.amourAmour()),
            buildCard(
                Icons.image,
                "Generate Meme",
                EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 20.0),
                () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SelectMeme())),
                FlutterGradients.newLife()),
            buildCard(
                Icons.crop_rotate,
                "Crop And Rotate",
                EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 20.0),
                () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CropRotateScreen())),
                FlutterGradients.happyMemories()),
            buildCard(
                Icons.compress,
                "Compress Image",
                EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 20.0),
                () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CompressImageScreen())),
                FlutterGradients.smartIndigo()),
          ],
        ),
      ),
    );
  }
}
