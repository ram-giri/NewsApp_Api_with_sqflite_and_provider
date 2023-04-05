import 'package:flutter/material.dart';
import 'package:news_app/services/db_service.dart';
import '../model/article_model.dart';
import 'api_service.dart';

// API
class ApiProvider extends ChangeNotifier {
  List<Article> _articles = [];
  ApiProvider() {
    ApiService.getArticle().then((value) {
      _articles = value;
      notifyListeners();
    });
  }
  List<Article> get articles => _articles;
}

//Local Database
class DBProvider extends ChangeNotifier {
  List<Article> _articles = [];
  void getArticle() async {
    _articles = await DBService.instance.getAllArticle();
    notifyListeners();
  }

  List<Article> get articles => _articles;

  void addArticle(Article article) async {
    await DBService.instance.addNews(article);
    getArticle();
  }

  void deleteArticle(String url) async {
    await DBService.instance.deleteArticle(url);
    getArticle();
  }
}
