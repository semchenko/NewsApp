import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_app/config/constants.dart';
import 'package:news_app/features/news/data/models/article.dart';
import 'package:news_app/core/data_state.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repository/article_repository.dart';

import '../data_services/news_api_service.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;

  ArticleRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<List<ArticleModel>>> getNews() async {
    return makeAPICall();
  }

  @override
  Future<DataState<List<ArticleEntity>>> refreshNews() async {
    return makeAPICall();
  }

  @override
  Future<DataState<List<ArticleEntity>>> fetchNews(int pageNumber) async {
    return makeAPICall(pageNumber: pageNumber);
  }

  Future<DataState<List<ArticleModel>>> makeAPICall({int? pageNumber}) async {
    try {
      final httpResponse = await _newsApiService.getArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
        pageSize: pageSize,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioError(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioErrorType.response,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
