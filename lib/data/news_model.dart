class NewsModel {
  final String title;
  final String source;
  final String? imageUrl;

  NewsModel({required this.title, required this.source, this.imageUrl});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? 'No title',
      source: json['source']?['name'] ?? 'Unknown',
      imageUrl: json['urlToImage'],
    );
  }
}
