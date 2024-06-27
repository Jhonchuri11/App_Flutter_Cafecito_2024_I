import 'dart:convert';

class SongModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final String mp3;
  final String author;

  SongModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.mp3,
    required this.author,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      mp3: json['mp3'] as String,
      author: json['author'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'mp3': mp3,
      'author': author
    };
  }
}

List<SongModel> songsFromJson(String str) {
  final jsonData = json.decode(str) as List;
  return List<SongModel>.from(
      jsonData.map((x) => SongModel.fromJson(x as Map<String, dynamic>)));
}
