import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/article_model.dart';

class ApiService {
   static const url =
"https://newsapi.org/v2/everything?q=nepal&from=2023-02-30&apiKey=465f348c3f9644efa9acc6f19ebaf28e";

// get data form api
  static Future<List<Article>> getArticle() async {
    try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List data = body['articles'];
        List<Article> articles =
            data.map((item) => Article.fromMap(item)).toList();
        return articles;      
    } else {
      throw Exception("Unable to Get News");
    }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
