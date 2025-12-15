import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/place_models.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2/jelajahrasa_api";

  static Future<List<Place>> getPlaces() async {
    final response = await http.get(
      Uri.parse("$baseUrl/places.php"),
    );

    print("API RESPONSE: ${response.body}");

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final List list = decoded['data'];
      return list.map((e) => Place.fromJson(e)).toList();
    } else {
      throw Exception("Gagal mengambil data tempat");
    }
  }
}
