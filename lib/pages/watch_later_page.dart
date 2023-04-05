import 'package:flutter/material.dart';
import 'package:news_app/components/article_widget.dart';
import 'package:news_app/services/provider.dart';
import 'package:provider/provider.dart';

class WatchLaterPage extends StatefulWidget {
  const WatchLaterPage({super.key});

  @override
  State<WatchLaterPage> createState() => _WatchLaterPageState();
}

class _WatchLaterPageState extends State<WatchLaterPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DBProvider>(context);
    var allArticle = provider.articles;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My News'),
      ),
      body: allArticle.isNotEmpty
          ? ListView.builder(
              itemCount: allArticle.length,
              itemBuilder: (context, index) {
                var article = allArticle[index];
                return ArticleWidget(
                  article: article,
                  index: index,
                  positionedchild: TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red[500],
                    ),
                    onPressed: () {
                      provider.deleteArticle(article.url);
                    },
                    icon: const Icon(Icons.delete_forever),
                    label: const Text('Remove'),
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
