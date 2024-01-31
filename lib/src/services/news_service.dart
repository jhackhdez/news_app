// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:http/http.dart' as http;

const _URL_NEWS = 'https://newsapi.org/v2';
const _APIKEY = '40370499442d488eb0d9b98f62d02928';

class NewsService with ChangeNotifier {
  List<Article> headLines = [];

  NewsService() {
    getTopHeadLines();
  }

  getTopHeadLines() async {
    // Ejecutar llamada http (nueva forma de hacerlo distinta a como se da en el curso)
    final url =
        Uri.parse('$_URL_NEWS/top-headlines?country=us&apiKey=$_APIKEY');
    http.Response resp = await http.get(url);
    try {
      if (resp.statusCode == 200) {
        final newsResponse = newsResponseFromJson(resp.body);
        // Asigno todos los artículos de la petición http a mi 'headLines'
        headLines.addAll(newsResponse.articles);
        // Notifico a los listeners
        notifyListeners();
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed';
    }
  }
}
