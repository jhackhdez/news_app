// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:http/http.dart' as http;

const _URL_NEWS = 'https://newsapi.org/v2';
const _APIKEY = '40370499442d488eb0d9b98f62d02928';

class NewsService with ChangeNotifier {
  List<Article> headLines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology')
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadLines();
    for (var item in categories) {
      categoryArticles[item.name] = List.empty();
    }
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String value) {
    _selectedCategory = value;
    getArticlesByCategory(value);
    notifyListeners();
  }

  get getArticulosCategoriaSeleccionada => categoryArticles[selectedCategory];

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

  // Este método concatena la 'category' seleccionada a la url para obtener la data filtrada
  getArticlesByCategory(String category) async {
    // condición para evitar insertar duplicados
    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }
    final url =
        Uri.parse('$_URL_NEWS/top-headlines?country=us&category=$category');
    http.Response resp = await http.get(url);
    // Se obtienen todos los artículos filtrados por la categoría seleccionada
    final newsResponse = newsResponseFromJson(resp.body);
    // Esto permite insertas las categorías seleccionadas dentro de la lista de artículos que corresponda
    categoryArticles[category]!.addAll(newsResponse.articles);
    // Notifico a los listeners
    notifyListeners();
  }
}
