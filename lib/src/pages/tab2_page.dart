import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category_model.dart';
import '../services/news_service.dart';
import '../theme/my_theme.dart';
import '../widgets/news_list.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewsService newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            const _CategoriesList(),
            newsService.isLoading
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: NewsList(news: newsService.articlesSelectedCategory),
                  ),
          ],
        ),
      ),
    );
  }
}

class _CategoriesList extends StatelessWidget {
  const _CategoriesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Category> categories =
        Provider.of<NewsService>(context).categories;

    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final String cName = categories[index].categoryName;

          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                _CategoryButton(category: categories[index]),
                const SizedBox(height: 5),
                Text('${cName[0].toUpperCase()}${cName.substring(1)}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  const _CategoryButton({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewsService newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        // print(category.categoryName);
        final NewsService newsService =
            Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.categoryName;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          category.icon,
          color: category.categoryName == newsService.selectedCategory
              ? myTheme.colorScheme.primary
              : Colors.black54,
        ),
      ),
    );
  }
}
