import 'package:tabbar_demo/data/news_model.dart';
import 'package:tabbar_demo/data/news_service.dart';

class NewsRepo {
  final NewsService _newsService = NewsService();

  Future<List<NewsModel>> fetchNewsByCategory(String category) async {
    return _newsService.getNewsByCategory(category).then((rawNews) {
      return rawNews
          .map<NewsModel>((json) => NewsModel.fromJson(json))
          .toList();
    });
  }
}
