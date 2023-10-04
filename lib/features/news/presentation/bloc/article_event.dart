abstract class ArticlesEvent {
  const ArticlesEvent();
}

class GetArticles extends ArticlesEvent {
  const GetArticles();
}

class RefreshArticles extends ArticlesEvent {
  const RefreshArticles();
}

class FetchArticles extends ArticlesEvent {
  final int currentPage;

  FetchArticles(this.currentPage);
}
