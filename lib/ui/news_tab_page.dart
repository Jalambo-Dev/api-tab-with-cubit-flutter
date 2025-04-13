import 'package:flutter/material.dart';
import 'package:tabbar_demo/ui/news_category_tab.dart';

class NewsTabsPage extends StatefulWidget {
  const NewsTabsPage({super.key});

  @override
  State<NewsTabsPage> createState() => _NewsTabsPageState();
}

class _NewsTabsPageState extends State<NewsTabsPage>
    with SingleTickerProviderStateMixin {
  final List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: categories.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News by Category'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: categories.map((c) => Tab(text: c.toUpperCase())).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: categories
            .map((category) => NewsCategoryTab(category: category))
            .toList(),
      ),
    );
  }
}
