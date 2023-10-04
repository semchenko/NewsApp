import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'features/news/data/data_services/news_api_service.dart';
import 'features/news/data/repository/article_repository_impl.dart';
import 'features/news/domain/repository/article_repository.dart';
import 'features/news/domain/usecases/fetch_articles.dart';
import 'features/news/domain/usecases/get_articles.dart';
import 'features/news/domain/usecases/refresh_articles.dart';
import 'features/news/presentation/bloc/article_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<NewsApiService>(NewsApiService(getIt()));
  getIt.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(getIt()));
  getIt.registerSingleton<GetArticlesUseCase>(GetArticlesUseCase(getIt()));
  getIt.registerSingleton<RefreshArticlesUseCase>(RefreshArticlesUseCase(getIt()));
  getIt.registerSingleton<FetchArticlesUseCase>(FetchArticlesUseCase(getIt()));
  getIt.registerSingleton<ArticlesBloc>(ArticlesBloc(getIt(), getIt(), getIt()));
}
