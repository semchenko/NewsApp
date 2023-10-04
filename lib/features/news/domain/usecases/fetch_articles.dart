import 'package:news_app/core/data_state.dart';
import 'package:news_app/core/usecase.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repository/article_repository.dart';

class FetchArticlesUseCase implements UseCase<DataState<List<ArticleEntity>>, int> {
  final ArticleRepository _articleRepository;

  FetchArticlesUseCase(
    this._articleRepository,
  );

  @override
  Future<DataState<List<ArticleEntity>>> call({ int params =0 }) {
    return _articleRepository.fetchNews(params);
  }
}
