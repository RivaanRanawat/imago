import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:imago/models/text_info.dart';
import 'package:imago/utils/repeated_functions.dart';
import 'package:imago/widgets/memeWidgets/default_button.dart';
import 'package:imago/widgets/memeWidgets/edit_meme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

abstract class EditMemeViewModel extends State<EditMeme> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  List<TextInfo> texts = [];
  int currentIndex = 0;

  saveToGallery(BuildContext context) async {
    if (texts.length > 0) {
      screenshotController.capture().then((Uint8List image) {
        saveImage(image);
      }).catchError((err) => print(err));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "No Text",
          style: TextStyle(fontSize: 16.0),
        ),
      ));
    }
  }

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(":", "-");
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    final res = await ImageGallerySaver.saveImage(bytes, name: name);
    return res["filePath"];
  }

  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Selected For Styling",
        style: TextStyle(fontSize: 16.0),
      ),
    ));
  }

  removeText(BuildContext context) {
    setState(() {
      texts.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Deleted",
        style: TextStyle(fontSize: 16.0),
      ),
    ));
  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize = texts[currentIndex].fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize = texts[currentIndex].fontSize -= 2;
    });
  }

  alignLeft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  alignRight() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
      print(texts[currentIndex].textAlign);
    });
  }

  alignCenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  boldText() {
    setState(() {
      if (texts[currentIndex].fontWeight == FontWeight.bold) {
        texts[currentIndex].fontWeight = FontWeight.normal;
      } else {
        texts[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  italicText() {
    setState(() {
      if (texts[currentIndex].fontStyle == FontStyle.italic) {
        texts[currentIndex].fontStyle = FontStyle.normal;
      } else {
        texts[currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }

  addLinesToText() {
    setState(() {
      texts[currentIndex].text = texts[currentIndex].text.replaceAll(' ', '\n');
    });
  }

  addNewText() {
    setState(() {
      texts.add(TextInfo(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          text: textEditingController.text,
          textAlign: TextAlign.left,
          fontSize: 20,
          left: 0,
          top: 0));
    });
  }

  addNewDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('Add New Text'),
              content: TextField(
                controller: textEditingController,
                maxLines: 5,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.edit),
                    filled: true,
                    hintText: 'Your Funny Text Here.'),
              ),
              actions: <Widget>[
                DefaultButton(
                  onPressed: addNewText,
                  child: Text('Add Text', style: TextStyle(color: Colors.black),),
                  color: Colors.white,
                  textColor: Colors.white,
                ),
                DefaultButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Back'),
                  color: Colors.red,
                  textColor: Colors.white,
                ),
              ],
            ));
  }
}
