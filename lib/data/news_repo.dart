import 'package:tabbar_demo/data/news_model.dart';
import 'package:tabbar_demo/data/news_service.dart';

class NewsRepo {
  final NewsService _newsService = NewsService();

  Future<List<NewsModel>> fetchNewsByCategory(String category, int page) async {
    try {
      return _newsService.getNewsByCategory(category, page).then((rawNews) {
        return rawNews
            .map<NewsModel>((json) => NewsModel.fromJson(json))
            .toList();
      });
    } catch (e) {
      throw Exception('Failed to fetch news: $e');
    }
  }
}
