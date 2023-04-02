import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/article_model.dart';

class ApiService {
  Future<List<Article>> getArticle() async {
    const url =
"https://newsapi.org/v2/everything?q=nepal&from=2023-02-30&apiKey=465f348c3f9644efa9acc6f19ebaf28e";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        var body = jsonDecode(response.body);
        List data = body['articles'];
        List<Article> articles =
            data.map((item) => Article.fromMap(item)).toList();
        return articles;
      } catch (e) {
        throw Exception(e.toString());
      }
    } else {
      throw Exception("Unable to Get News");
    }
  }
}

// class ApiProvider extends ChangeNotifier {
//   List<Article> article = [];
//   ApiProvider() {
//     ApiService().getArticle().then((value) {
//       article = value;
//       notifyListeners();
//     });
//   }
// }

// class ApiProvider extends ChangeNotifier {
//   List<Article> article = [];
//   ApiProvider() {
//     _loadArticles();
//   }
//   Future<void> _loadArticles() async {
//     article = await ApiService().getArticle();
//     notifyListeners();
//   }
// }
