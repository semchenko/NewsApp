import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../config/constants.dart';
import '../../domain/entities/article.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity? article;
  final void Function(ArticleEntity article)? onArticlePressed;

  const ArticleWidget({
    Key? key,
    this.article,
    this.onArticlePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsetsDirectional.only(start: 14, end: 14, bottom: 7, top: 7),
        height: MediaQuery.of(context).size.height / 4.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            Row(
              children: [
                _buildImage(context),
                _buildDescription(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.width / 4,
      child: CachedNetworkImage(
          imageUrl: article?.urlToImage ?? defaultImage,
          imageBuilder: (context, imageProvider) => Padding(
                padding: const EdgeInsetsDirectional.only(end: 14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.08),
                        image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
                  ),
                ),
              ),
          progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
                padding: const EdgeInsetsDirectional.only(end: 14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: double.maxFinite,
                    child: const CircularProgressIndicator(),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                    ),
                  ),
                ),
              ),
          errorWidget: (context, url, error) => Padding(
                padding: const EdgeInsetsDirectional.only(end: 14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: double.maxFinite,
                    child: const Icon(Icons.error),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                    ),
                  ),
                ),
              )),
    );
  }

  Widget _buildTitle() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.timeline_outlined, size: 16),
                const SizedBox(width: 4),
                Text(
                  (article?.publishedAt ?? '').substring(0, 10),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Text(
              article?.title ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          article?.description ?? '',
          style: const TextStyle(fontSize: 13),
          maxLines: 4,
        ),
      ),
    );
  }

  void _onTap() {
    if (onArticlePressed != null) {
      onArticlePressed!(article!);
    }
  }
}
