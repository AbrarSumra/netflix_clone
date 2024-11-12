import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_model/movie_model.dart';

class ApiService {
  // Replace with your API URL
  final String apiUrl = 'https://api.tvmaze.com/search/shows?q=all';

  Future<List<Show>> fetchShows() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Show.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load shows');
      }
    } catch (e) {
      throw Exception('Error fetching shows: $e');
    }
  }

  Future<List<Show>> searchShows(String searchTerm) async {
    final url = 'https://api.tvmaze.com/search/shows?q=$searchTerm';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        print(data);
        return data.map((json) => Show.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load shows');
      }
    } catch (e) {
      throw Exception('Error fetching shows: $e');
    }
  }
}
