import 'package:news_app/features/news/domain/entities/article.dart';
import '../../../../config/constants.dart';

const _keyAuthor = 'author';
const _keyTitle = 'title';
const _keyDescription = 'description';
const _keyUrl = 'url';
const _keyUrlToImage = 'urlToImage';
const _keyPublishedAt = 'publishedAt';
const _keyContent = 'content';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    int? id,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) : super(
          id: id,
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      author: map[_keyAuthor] ?? "",
      title: map[_keyTitle] ?? "",
      description: map[_keyDescription] ?? "",
      url: map[_keyUrl] ?? "",
      urlToImage: map[_keyUrlToImage] != null && map[_keyUrlToImage] != "" ? map[_keyUrlToImage] : defaultImage,
      publishedAt: map[_keyPublishedAt] ?? "",
      content: map[_keyContent] ?? "",
    );
  }

  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
        id: entity.id,
        author: entity.author,
        title: entity.title,
        description: entity.description,
        url: entity.url,
        urlToImage: entity.urlToImage,
        publishedAt: entity.publishedAt,
        content: entity.content);
  }
}