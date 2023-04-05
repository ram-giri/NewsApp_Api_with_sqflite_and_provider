import 'package:flutter/material.dart';
import 'package:news_app/services/provider.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ApiProvider()),
      ChangeNotifierProvider(create: (_) => DBProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
