import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/news_models.dart';
import '../services/news_service.dart';
import '../widgets/news_list.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({Key? key}) : super(key: key);

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // VER NOTA ABAJO
    final List<Article> headlines = Provider.of<NewsService>(context).headlines;

    return Scaffold(
      body: headlines.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : NewsList(news: headlines),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/**
 * SOLUCIONAR EL WARNING "This method overrides a method annotated as '@mustCallSuper' in 'AutomaticKeepAliveClientMixin', but doesn't invoke the overridden method". VER:
 * https://dart.dev/tools/diagnostic-messages?utm_source=dartdev&utm_medium=redir&utm_id=diagcode&utm_content=must_call_super#must_call_super
 * https://stackoverflow.com/questions/53869795/flutters-automatickeepaliveclientmixin-doesnt-keep-the-page-state-after-naviga
 */
