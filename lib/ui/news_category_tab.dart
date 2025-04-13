import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tabbar_demo/data/news_model.dart';
import 'package:tabbar_demo/data/news_repo.dart';

class NewsCategoryTab extends StatefulWidget {
  final String category;
  const NewsCategoryTab({super.key, required this.category});

  @override
  State<NewsCategoryTab> createState() => _NewsCategoryTabState();
}

class _NewsCategoryTabState extends State<NewsCategoryTab>
    with AutomaticKeepAliveClientMixin {
  final NewsRepo _newsRepository = NewsRepo();
  bool hasFetched = false;
  bool isLoading = false;
  List<NewsModel> news = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!hasFetched) {
      hasFetched = true;
      loadNews();
    }
  }

  Future<void> loadNews() async {
    setState(() => isLoading = true);
    try {
      final fetchedNews =
          await _newsRepository.fetchNewsByCategory(widget.category);
      setState(() {
        news = fetchedNews;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      log('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (isLoading) return Center(child: CircularProgressIndicator());
    if (news.isEmpty) return Center(child: Text('No News'));

    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Image.network(
                news[index].imageUrl ??
                    'https://salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png', // Placeholder image
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news[index].title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      news[index].source,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
