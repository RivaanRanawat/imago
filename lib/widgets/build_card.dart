import 'package:flutter/material.dart';

Widget buildCard(IconData icon, String text, EdgeInsets margin, Function onTap) {
  return GestureDetector(
    onTap: onTap,
      child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 7.0,
      child: Column(
        children: <Widget>[
          SizedBox(height: 12.0),
          Stack(
            children: <Widget>[
              Container(
                height: 100.0,
                width: 100.0,
                child: Icon(
                  icon,
                  size: 40,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Expanded(
              child: Container(
                  width: 175.0,
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                  child: Center(
                    child: Text(
                      text,
                      style:
                          TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  )))
        ],
      ),
      margin: margin,
    ),
  );
}
