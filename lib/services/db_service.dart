import 'package:news_app/model/article_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static final DBService instance = DBService._init();
  static Database? _database;
  String dbName = 'news_manager.db';
  String tableName = 'News';
  DBService._init();

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await _initDB(dbName);
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Create the database and the News table
  Future _createDB(Database db, int version) async {
    String sql = '''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY,
            sourceID TEXT,
            sourceName TEXT,
            author TEXT,
            title TEXT,
            description TEXT,
            url TEXT,
            urlToImage TEXT,
            publishedAt TEXT,
            content TEXT
          )
          ''';
    await db.execute(sql);
  }

  // Insert News on database
  Future<void> addNews(Article news) async {
    final db = await database;
    List<Map<String, dynamic>> result =
        await db!.query(tableName, where: 'url = ?', whereArgs: [news.url]);
    if (result.isNotEmpty) {
      // If news already exists, update the existing
      await db.update(tableName, news.toMap(),
          where: 'url = ?', whereArgs: [news.url]);
    } else {
      // If news doesn't exist, insert a new
      await db.insert(tableName, news.toMap());
    }
  }

  // Get all Articles
  Future<List<Article>> getAllArticle() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db!.query(tableName);
    return List.generate(
      maps.length,
      (i) => Article(
          sourceID: maps[i]['sourceID'],
          sourceName: maps[i]['sourceName'],
          author: maps[i]['author'],
          title: maps[i]['title'],
          description: maps[i]['description'],
          url: maps[i]['url'],
          urlToImage: maps[i]['urlToImage'],
          publishedAt: DateTime.parse(maps[i]['publishedAt']),
          content: maps[i]['content']),
    ).toList();
  }

  // Delete Article by url
  Future<bool> deleteArticle(String url) async {
    final db = await instance.database;
    await db!.delete(
      tableName,
      where: 'url = ?',
      whereArgs: [url],
    );
    return true;
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }
}
