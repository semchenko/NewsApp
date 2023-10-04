import 'package:news_app/core/data_state.dart';
import 'package:news_app/features/news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNews();
  Future<DataState<List<ArticleEntity>>> refreshNews();
  Future<DataState<List<ArticleEntity>>> fetchNews(int pageNumber);
}