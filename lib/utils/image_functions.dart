import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:convert';

class Utility {
  // returns an image
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  // decodes base64 to uint8list
  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  // encodes bytes to base64
  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
