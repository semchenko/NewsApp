import 'package:dio/dio.dart';
import '../../domain/entities/article.dart';

abstract class ArticlesState {
  final List<ArticleEntity> articles;
  final DioError? error;

  const ArticlesState({required this.articles, this.error});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticlesState && runtimeType == other.runtimeType && articles == other.articles && error == other.error;

  @override
  int get hashCode => articles.hashCode ^ error.hashCode;

  @override
  String toString() {
    return 'ArticlesState{articles: $articles, error: $error}';
  }
}

class ArticlesLoading extends ArticlesState {
  const ArticlesLoading() : super(articles: const <ArticleEntity>[]);
}

class ArticlesLoaded extends ArticlesState {
  const ArticlesLoaded(List<ArticleEntity> article) : super(articles: article);
}

class ArticlesError extends ArticlesState {
  const ArticlesError(DioError error) : super(articles: const <ArticleEntity>[]) ;
}
