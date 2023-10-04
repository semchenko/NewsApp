import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/article_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/article_state.dart';
import '../../../../config/constants.dart';
import '../../domain/entities/article.dart';
import '../bloc/article_event.dart';
import '../widgets/article_tile.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _currentPage++;
      context.read<ArticlesBloc>().add(FetchArticles(_currentPage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
        appTitle,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<ArticlesBloc, ArticlesState>(
      builder: (_, state) {
        if (state is ArticlesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ArticlesError) {
          return GestureDetector(
            child: const Center(child: Icon(Icons.refresh)),
            onTap: () async {
              context.read<ArticlesBloc>().add(const RefreshArticles());
            },
          );
        }
        if (state is ArticlesLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ArticlesBloc>().add(const RefreshArticles());
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < state.articles.length) {
                        return ArticleWidget(
                          article: state.articles[index],
                          onArticlePressed: (article) => _onArticlePressed(context, article),
                        );
                      } else if (state is ArticlesLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return null;
                      }
                    },
                    childCount: state.articles.length + 1,
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }
}
