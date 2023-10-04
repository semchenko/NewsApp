import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/data_state.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/usecases/get_articles.dart';
import 'package:news_app/features/news/presentation/bloc/article_event.dart';
import 'package:news_app/features/news/presentation/bloc/article_state.dart';

import '../../domain/usecases/fetch_articles.dart';
import '../../domain/usecases/refresh_articles.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final GetArticlesUseCase _getArticleUseCase;
  final RefreshArticlesUseCase _refreshArticlesUseCase;
  final FetchArticlesUseCase _fetchArticlesUseCase;

  ArticlesBloc(
    this._getArticleUseCase,
    this._refreshArticlesUseCase,
    this._fetchArticlesUseCase,
  ) : super(const ArticlesLoading()) {

    on<GetArticles>(onGetArticles);
    on<RefreshArticles>(onRefreshArticles);
    on<FetchArticles>(onFetchArticles);
  }

  void onGetArticles(GetArticles event, Emitter<ArticlesState> emit) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess) {
      emit(ArticlesLoaded(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(ArticlesError(dataState.error!));
    }
  }

  void onRefreshArticles(RefreshArticles event, Emitter<ArticlesState> emit) async {
    final dataState = await _refreshArticlesUseCase();

    if (dataState is DataSuccess) {
      emit(ArticlesLoaded(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(ArticlesError(dataState.error!));
    }
  }

  void onFetchArticles(FetchArticles event, Emitter<ArticlesState> emit) async {
    final dataState = await _fetchArticlesUseCase(params: event.currentPage);

    if (dataState is DataSuccess) {
      emit(ArticlesLoaded( <ArticleEntity>[...state.articles, ...dataState.data!]));
    }

    if (dataState is DataFailed) {
      emit(ArticlesError(dataState.error!));
    }
  }
}
