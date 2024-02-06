import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final headLines = Provider.of<NewsService>(context).headLines;
    // newsService.headlines

    return Scaffold(body: ListNews(headLines));
  }
}
