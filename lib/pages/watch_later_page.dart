import 'package:flutter/material.dart';
import 'package:news_app/components/article_widget.dart';
import 'package:news_app/services/db_service.dart';

class WatchLaterPage extends StatefulWidget {
  const WatchLaterPage({super.key});

  @override
  State<WatchLaterPage> createState() => _WatchLaterPageState();
}

class _WatchLaterPageState extends State<WatchLaterPage> {
  @override
  Widget build(BuildContext context) {
    var future = DBService.instance.getAllNews();
    return Scaffold(
      appBar: AppBar(
        title: const Text('My News'),
      ),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          var allArticle = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: allArticle!.length,
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
                      DBService.instance.deleteArticle(article.url);
                      DBService.instance.getAllNews();
                      setState(() {});
                    },
                    icon: const Icon(Icons.delete_forever),
                    label: const Text('Remove'),
                  ),
                );
              },
            );
          } else if (snapshot.data == null) {
            return const Center(child: Text('No News Found'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
