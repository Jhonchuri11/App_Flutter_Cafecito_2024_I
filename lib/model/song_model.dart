import 'dart:convert';

class SongModel {
  late int? id;
  late String? title;
  late String? description;
  late String? image;
  late String? author;

  SongModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.author,
  });

  SongModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['image'] = image;
    _data['author'] = author;
    return _data;
  }
}

List<SongModel> songsFromJson(dynamic str) =>
    List<SongModel>.from((str).map((x) => SongModel.fromJson(x)));
