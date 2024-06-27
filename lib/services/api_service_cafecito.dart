import 'dart:convert';
import 'package:cafecitodev/services/config_cafecito.dart';
import 'package:http/http.dart' as http;
import 'package:cafecitodev/model/song_model.dart';

class ApiServiceCafecito {
  static var client = http.Client();

  static Future<List<SongModel>> getSongs() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(ConfigCafecito.apiURL);

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
    var url = Uri.parse(ConfigCafecito.apiURLAdd);

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(songModel.toJson()));

    if (response.statusCode == 201) {
      return SongModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to creadte");
    }
  }
}
