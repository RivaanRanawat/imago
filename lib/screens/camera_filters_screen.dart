import 'package:avatar_view/avatar_view.dart';
import "package:flutter/material.dart";
import "package:camera_deep_ar/camera_deep_ar.dart";
import 'package:imago/widgets/memeWidgets/default_button.dart';

class CameraFilterScreen extends StatefulWidget {
  @override
  _CameraFilterScreenState createState() => _CameraFilterScreenState();
}

class _CameraFilterScreenState extends State<CameraFilterScreen> {
  CameraDeepArController cameraDeepArController;
  String _platformVersion = 'Unknown';
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffect = Effects.none;
  Filters currentFilter = Filters.none;
  Masks currentMask = Masks.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CameraDeepAr(
            cameraDeepArCallback: (c) async {
              cameraDeepArController = c;
              setState(() {});
            },
            onCameraReady: (isReady) {
              _platformVersion = "Camera status $isReady";
              print(_platformVersion);
              setState(() {});
            },
            onImageCaptured: (path) {
              _platformVersion = "Image save at $path";
              setState(() {});
            },
            androidLicenceKey:
                "2fbc95a68dd06f2281cc278a0130a1f07cd7f1e8dbf34bd62f44423477081a1d62654c0976c652c7",
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 28, right: 28),
                    child: Expanded(
                      child: DefaultButton(
                        color: Colors.white54,
                        textColor: Colors.black,
                        child: Icon(Icons.camera_enhance),
                        onPressed: () async {
                          if (cameraDeepArController == null) {
                            return;
                          }
                          await cameraDeepArController.snapPhoto();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Image saved to gallery!"),
                          ));
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(8, (index) {
                        var active = currentPage == index;

                        return GestureDetector(
                          onTap: () {
                            currentPage = index;
                            cameraDeepArController.changeMask(index);
                            setState(() {});
                          },
                          child: AvatarView(
                            radius: active ? 45 : 25,
                            borderColor: Colors.yellow,
                            borderWidth: 2,
                            isOnlyText: false,
                            avatarType: AvatarType.CIRCLE,
                            backgroundColor: Colors.red,
                            imagePath: "assets/filters/${index.toString()}.jpg",
                            placeHolder: Icon(Icons.person, size: 50),
                            errorWidget: Container(
                              child: Icon(Icons.error, size: 50),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
