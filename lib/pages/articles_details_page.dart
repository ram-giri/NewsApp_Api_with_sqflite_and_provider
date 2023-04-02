import 'package:flutter/material.dart';
import 'package:news_app/model/article_model.dart';

class ArticlePage extends StatelessWidget {
  final Article article;
  final num i;

  const ArticlePage({super.key, required this.article, required this.i});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200.0,
              width: double.infinity,
              child: Hero(
                  tag: 'hero-$i',
                  child: Image.network(
                    article.urlToImage,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
              return Image.asset('images/no-image.png',
                  width:double.infinity, height: 200, fit: BoxFit.contain);
            },
                  )),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                article.sourceName,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              article.description,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
