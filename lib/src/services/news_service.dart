// ignore_for_file: constant_identifier_names

// CATEGORIES: business entertainment general health science sports technology

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../models/category_model.dart';
import '../models/news_models.dart';

// Tambien valdria como un mixins(with)
class NewsService extends ChangeNotifier {
  static const _URL_NEWS = 'newsapi.org';

  static const _PATH = '/v2/top-headlines';

  static const _API_KEY = '431a2b39236d43baaafbf67530faa12d';

  List<Article> headlines = [];

  String _selectedCategory = 'business';

  bool _isLoading = true;

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();

    for (var item in categories) {
      categoryArticles[item.categoryName] = [];
    }

    getArticleByCategory(_selectedCategory);
  }

  bool get isLoading => _isLoading;

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;

    _isLoading = true;
    getArticleByCategory(value);

    notifyListeners();
  }

  List<Article> get articlesSelectedCategory =>
      categoryArticles[selectedCategory]!;

  Future<void> getTopHeadlines() async {
    final Uri url =
        Uri.https(_URL_NEWS, _PATH, {'country': 'ar', 'apiKey': _API_KEY});

    final resp = await http.get(url);

    final NewsResponse newsResponse = NewsResponse.fromJson(resp.body);

    headlines.addAll(newsResponse.articles);

    notifyListeners();
  }

  Future<void> getArticleByCategory(String category) async {
    // Con esto evitamos hacer nuevas peticiones http
    // y cacheamos en memoria las listas de articulos por categorias
    if (categoryArticles[category]!.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
    }

    final Uri url = Uri.https(
      _URL_NEWS,
      _PATH,
      {
        'country': 'ar',
        'category': category,
        'apiKey': _API_KEY,
      },
    );

    final resp = await http.get(url);

    final NewsResponse newsResponse = NewsResponse.fromJson(resp.body);

    categoryArticles[category]!.addAll(newsResponse.articles);

    _isLoading = false;

    notifyListeners();
  }
}

/**
 * VIDEO DE YOUTUBE SOBRE PROVIDERS. VER;
 * https://www.youtube.com/watch?v=-KX2rH0qdKA
 * 
 * SOBRE EL USO DEL MODIFICADOR ASYNC EN SETTERS O GETTERS. VER:
 * The modifier async can not by applied to the body of a setter:
 * https://stackoverflow.com/questions/61497139/the-modifier-async-can-not-by-applied-to-the-body-of-a-setter
 */
