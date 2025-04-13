import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  static const String _baseUrl = 'https://newsapi.org/v2/top-headlines';
  static const String _apiKey = '555c2576b0fc4f7f874703cb16e58319';

  Future<List<dynamic>> getNewsByCategory(String category , int page) async {
    final uri =
        Uri.parse("$_baseUrl?country=us&category=$category&page=$page&apiKey=$_apiKey");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
