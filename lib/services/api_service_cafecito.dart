import 'dart:convert';
import 'package:cafecitodev/services/config_cafecito.dart';
import 'package:http/http.dart' as http;
import 'package:cafecitodev/model/song_model.dart';

class ApiServiceCafecito {
  static var client = http.Client();

  static const String apiUrl =
      "http://192.168.18.76:8080/api/cafecito/v1/songs";

  static Future<List<SongModel>> getSongs() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(ConfigCafecito.api);

    try {
      var response = await client.get(url, headers: requestHeaders);

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        return data.map((item) => SongModel.fromJson(item)).toList();
      } else {
        print('Failed to load songs, status code: ${response.statusCode}');
        throw Exception('Failed to load songs!');
      }
    } catch (e) {
      print('Exception caught: $e');
      throw Exception('Failed to load songs!');
    }
  }

  Future<SongModel> createSong(SongModel songModel) async {
    var url = Uri.parse(ConfigCafecito.api);

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(songModel.toJson()));

    if (response.statusCode == 201) {
      return SongModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to creadte");
    }
  }

  static Future<bool> saveSong(
    SongModel model,
    bool isEditMode,
  ) async {
    var songUrl = ConfigCafecito.api;

    if (isEditMode) {
      songUrl = songUrl + "/" + model.id.toString();
    }

    var url = Uri.http(ConfigCafecito.api, songUrl);

    var requiredMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requiredMethod, url);
    request.fields["title"] = model.title!;
    request.fields["description"] = model.description!;
    request.fields["image"] = model.image!;
    request.fields["author"] = model.author!;

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteSong(id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    return response.statusCode == 200;
  }
}
