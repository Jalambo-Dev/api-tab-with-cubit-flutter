import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabbar_demo/data/news_model.dart';
import 'package:tabbar_demo/data/news_repo.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepo newsRepo;
  final String category;

  int _currentPage = 1;
  bool _isFetchingMore = false;
  bool _hasFetchedOnce = false;

  NewsCubit({
    required this.newsRepo,
    required this.category,
  }) : super(NewsState(status: NewsStatus.loading));

  // called from didChangeDependencies
  void fetchIfNeeded() {
    if (!_hasFetchedOnce) {
      _hasFetchedOnce = true;
      fetchNews();
    }
  }

  Future<void> fetchNews() async {
    emit(state.copyWith(status: NewsStatus.loading));
    try {
      final articles =
          await newsRepo.fetchNewsByCategory(category, _currentPage);
      emit(state.copyWith(status: NewsStatus.loaded, news: articles));
    } catch (e) {
      emit(
          state.copyWith(status: NewsStatus.error, errorMassage: e.toString()));
    }
  }

  Future<void> fetchMore() async {
    if (_isFetchingMore) return;
    _isFetchingMore = true;
    _currentPage++;

    try {
      final moreNews =
          await newsRepo.fetchNewsByCategory(category, _currentPage);
      final updatedList = [...?state.news, ...moreNews];
      emit(state.copyWith(news: updatedList));
    } catch (e) {
      // optionally handle pagination error
    } finally {
      _isFetchingMore = false;
    }
  }
}
