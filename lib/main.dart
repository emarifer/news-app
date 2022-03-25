import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:provider/provider.dart';

import 'package:news_app/src/pages/tabs_page.dart';
import 'package:news_app/src/theme/my_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // lazy: false, // VER NOTA ABAJO:
          create: (_) => NewsService(),
        ),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        home: const TabsPage(),
      ),
    );
  }
}

/**
 * NOTA:
 * CUANDO SE CREA UNA INSTANCIA DEL PROVIDER(NewsService, EN ESTE CASO)
 * SE LLAMA AUTOMATICAMENTE AL ChangeNotifierProvider. EL VALOR POR DEFECTO
 * DE lazy(«perezoso») ES true. SI SE PONE EN false, SIEMPRE SE CONSTRUIRA
 * LA INSTANCIA DEL PROVIDER (NewsService); SI ESTA EN true, SOLO SE CREARA
 * EL PROVIDER CUANDO EN ALGUNA PARTE DE LA APLICACION SE LLAME AL CONSTRUCTOR
 * DEL NewsService.
 * 
 * VIDEO DE YOUTUBE SOBRE PROVIDERS. VER;
 * https://www.youtube.com/watch?v=-KX2rH0qdKA
 * 
 * SOLUCIONAR EL WARNING "This method overrides a method annotated as '@mustCallSuper' in 'AutomaticKeepAliveClientMixin', but doesn't invoke the overridden method". VER:
 * https://dart.dev/tools/diagnostic-messages?utm_source=dartdev&utm_medium=redir&utm_id=diagcode&utm_content=must_call_super#must_call_super
 * https://stackoverflow.com/questions/53869795/flutters-automatickeepaliveclientmixin-doesnt-keep-the-page-state-after-naviga
 * 
 * SOBRE EL USO DEL MODIFICADOR ASYNC EN SETTERS O GETTERS. VER:
 * The modifier async can not by applied to the body of a setter:
 * https://stackoverflow.com/questions/61497139/the-modifier-async-can-not-by-applied-to-the-body-of-a-setter
 */
