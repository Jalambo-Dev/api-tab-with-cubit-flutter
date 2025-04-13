part of 'news_cubit.dart';

enum NewsStatus { loading, loaded, error }

extension NewsStatusX on NewsState {
  bool get isLoading => status == NewsStatus.loading;
  bool get isLoaded => status == NewsStatus.loaded;
  bool get isError => status == NewsStatus.error;
}

class NewsState {
  final NewsStatus status;
  final List<NewsModel>? news;
  final String? errorMassage;

  NewsState({
    required this.status,
    this.news,
    this.errorMassage,
  });

  NewsState copyWith({
    NewsStatus? status,
    List<NewsModel>? news,
    String? errorMassage,
  }) {
    return NewsState(
      status: status ?? this.status,
      news: news ?? this.news,
      errorMassage: errorMassage ?? this.errorMassage,
    );
  }

  @override
  String toString() =>
      'NewsState(status: $status, news: $news, errorMassage: $errorMassage)';

  @override
  bool operator ==(covariant NewsState other) {
    if (identical(this, other)) return true;
    return other.status == status &&
        listEquals(other.news, news) &&
        other.errorMassage == errorMassage;
  }

  @override
  int get hashCode => status.hashCode ^ news.hashCode ^ errorMassage.hashCode;
}
