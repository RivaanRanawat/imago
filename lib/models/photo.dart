class Photo {
  int id;
  String photoName;

  Photo(this.id, this.photoName);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'photo_name': photoName,
    };
    return map;
  }

  Photo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    photoName = map['photo_name'];
  }
}
