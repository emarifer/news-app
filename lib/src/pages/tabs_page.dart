import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_app/src/pages/tab1_page.dart';
import 'package:news_app/src/pages/tab2_page.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: const Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      currentIndex: navigationModel.currentPage,
      onTap: (i) => navigationModel.currentPage = i,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Para ti',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: 'Titulares',
        ),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);
    return PageView(
      // physics: const BouncingScrollPhysics(),
      controller: navigationModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const <Widget>[
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

// Aqui usamos mixins
class _NavigationModel with ChangeNotifier {
  int _currentPage = 0;

  final PageController _pageController = PageController();

  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    _pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
    // Ejecutamos el procedimiento de notificar a los widgets
    // para que se redibujen
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
