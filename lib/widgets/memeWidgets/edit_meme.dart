import 'package:flutter/material.dart';
import 'package:imago/widgets/memeWidgets/edit_meme_viewmodel.dart';
import 'package:imago/widgets/memeWidgets/meme_text.dart';
import 'package:screenshot/screenshot.dart';

class EditMeme extends StatefulWidget {
  final String selectedMeme;

  EditMeme({@required this.selectedMeme});

  @override
  _EditMemeState createState() => _EditMemeState();
}

class _EditMemeState extends EditMemeViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _addNewTextFab,
      appBar: _appBar,
      body: Screenshot(
        controller: screenshotController,
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              _selectedMeme,
              for (int i = 0; i < texts.length; i++)
                Positioned(
                    left: texts[i].left,
                    top: texts[i].top,
                    child: GestureDetector(
                        onLongPress: () {
                          setState(() {
                            currentIndex = i;
                            removeText(context);
                          });
                        },
                        onTap: () => setCurrentIndex(context, i),
                        child: Draggable(
                          feedback: MemeText(textInfo: texts[i]),
                          child: MemeText(textInfo: texts[i]),
                          onDragEnd: (drag) {
                            RenderBox renderBox = context.findRenderObject();
                            Offset off = renderBox.globalToLocal(drag.offset);
                            setState(() {
                              texts[i].top = off.dy-80;
                              texts[i].left = off.dx;
                            });
                          },
                        ))),
              creatorText.text.length > 0
                  ? Positioned(
                      left: 0,
                      bottom: 0,
                      child: Text(creatorText.text,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(.3))),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _appBar => AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Container(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.black,
                ),
                onPressed: () => saveToGallery(context),
                tooltip: 'Save Meme',
              ),
              IconButton(
                tooltip: 'Increase Font Size',
                icon: Icon(Icons.add, color: Colors.black),
                onPressed: increaseFontSize,
              ),
              IconButton(
                tooltip: 'Decrease Font Size',
                icon: Icon(Icons.remove, color: Colors.black),
                onPressed: decreaseFontSize,
              ),
              IconButton(
                tooltip: 'Align Left',
                icon: Icon(Icons.format_align_left, color: Colors.black),
                onPressed: alignLeft,
              ),
              IconButton(
                tooltip: 'Align Cneter',
                icon: Icon(Icons.format_align_center, color: Colors.black),
                onPressed: alignCenter,
              ),
              IconButton(
                tooltip: 'Align Right',
                icon: Icon(Icons.format_align_right, color: Colors.black),
                onPressed: alignRight,
              ),
              IconButton(
                tooltip: 'Bold',
                icon: Icon(Icons.format_bold, color: Colors.black),
                onPressed: boldText,
              ),
              IconButton(
                tooltip: 'Italic',
                icon: Icon(Icons.format_italic, color: Colors.black),
                onPressed: italicText,
              ),
              IconButton(
                tooltip: 'Add New Line',
                icon: Icon(Icons.space_bar, color: Colors.black),
                onPressed: addLinesToText,
              ),
              Tooltip(
                message: 'Red',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.red),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'White',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.white),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'Black',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.black),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'blue',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.blue),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'yellow',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.yellow),
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'green',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.green),
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'orange',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.orange),
                  child: CircleAvatar(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Tooltip(
                message: 'pink',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.pink),
                  child: CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget get _addNewTextFab => FloatingActionButton(
        backgroundColor: Colors.white,
        tooltip: 'Add New Text',
        child: Icon(
          Icons.edit,
          color: Colors.black,
        ),
        onPressed: () => addNewDialog(context),
      );

  Widget get _selectedMeme => Image.asset(
        widget.selectedMeme,
        fit: BoxFit.fill,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      );
}
