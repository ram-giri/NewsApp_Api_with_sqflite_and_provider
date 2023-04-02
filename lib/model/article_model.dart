class Article {
  final String sourceID;
  final String sourceName;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;
  Article({
    required this.sourceName,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.sourceID,
  });

  factory Article.fromMap(Map<String, dynamic> json) => Article(
        sourceID: json["source"]["id"] ?? 'null',
        sourceName: json["source"]["name"],
        author: json["author"] ?? 'Author',
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage:
            json["urlToImage"] ?? 'https://thumbs.dreamstime.com/b/news-newspapers-folded-stacked-word-wooden-block-puzzle-dice-concept-newspaper-media-press-release-42301371.jpg',
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toMap() => {
        "sourceID": sourceID,
        "sourceName": sourceName,
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}
