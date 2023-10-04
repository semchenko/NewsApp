import 'package:flutter/material.dart';

import '../features/news/domain/entities/article.dart';
import '../features/news/presentation/pages/article_detail.dart';
import '../features/news/presentation/pages/news.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const NewsScreen());
      case '/ArticleDetails':
        return _materialRoute( ArticleDetailsView(article: settings.arguments as ArticleEntity));
      default:
        return _materialRoute(const NewsScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
