import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/news_cubit.dart';

class NewsCategoryTab extends StatefulWidget {
  final String category;
  const NewsCategoryTab({super.key, required this.category});

  @override
  State<NewsCategoryTab> createState() => _NewsCategoryTabState();
}

class _NewsCategoryTabState extends State<NewsCategoryTab>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<NewsCubit>().fetchIfNeeded();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      context.read<NewsCubit>().fetchMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state.isLoading && state.news == null) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.isError) {
          return Center(child: Text(state.errorMassage ?? 'Unknown error'));
        }

        final news = state.news ?? [];
        return ListView.builder(
          controller: _scrollController,
          itemCount: news.length,
          itemBuilder: (_, i) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              spacing: 8,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: news[i].imageUrl ?? 'assets/not-founded.png',
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/not-founded.png',
                    ),
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news[i].title,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        news[i].source,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
