import 'package:flutter/material.dart';
import 'package:news_app/model/article_model.dart';
import '../pages/articles_details_page.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.article, required this.index, required this.positionedchild});
  final Article article;
  final int index;
  final Widget positionedchild;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      elevation: 5,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ArticlePage(article: article, i: index)));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200.0,
                    width: double.infinity,
                    child: Hero(
                        tag: 'hero-$index',
                        child: Image.network(
                          article.urlToImage,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset('images/no-image.png',
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.contain);
                          },
                        )),
                  ),
                  const SizedBox(height: 8.0),
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
                  const SizedBox(height: 8.0),
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 205,
            right: 8,
            child: positionedchild
          ),
        ],
      ),
    );
  }
}
