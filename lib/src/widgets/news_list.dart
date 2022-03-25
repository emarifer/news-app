import 'package:flutter/material.dart';

import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/theme/my_theme.dart';

class NewsList extends StatelessWidget {
  const NewsList({
    Key? key,
    required this.news,
  }) : super(key: key);

  final List<Article> news;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: news.length,
      itemBuilder: (BuildContext context, int index) {
        return _New(noticia: news[index], index: index);
      },
    );
  }
}

class _New extends StatelessWidget {
  const _New({
    Key? key,
    required this.noticia,
    required this.index,
  }) : super(key: key);

  final Article noticia;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _CardTopBar(noticia: noticia, index: index),
        _CardTitle(noticia: noticia),
        _CardImage(noticia: noticia),
        _CardBody(noticia: noticia),
        _CardButtons(),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }
}

class _CardButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            child: const Icon(Icons.star_border),
            fillColor: myTheme.colorScheme.primary,
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(width: 15),
          RawMaterialButton(
            child: const Icon(Icons.more),
            fillColor: Colors.blue,
            onPressed: () {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  final Article noticia;

  const _CardBody({
    Key? key,
    required this.noticia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(noticia.description ?? ''),
    );
  }
}

class _CardImage extends StatelessWidget {
  final Article noticia;

  const _CardImage({
    Key? key,
    required this.noticia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        child: Container(
          child: noticia.urlToImage != null
              ? FadeInImage(
                  placeholder: const AssetImage('assets/img/giphy.gif'),
                  image: NetworkImage(noticia.urlToImage!),
                )
              : const Image(image: AssetImage('assets/img/no-image.png')),
        ),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({
    Key? key,
    required this.noticia,
  }) : super(key: key);

  final Article noticia;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        noticia.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CardTopBar extends StatelessWidget {
  const _CardTopBar({
    Key? key,
    required this.noticia,
    required this.index,
  }) : super(key: key);

  final Article noticia;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Text(
            '${index + 1}. ',
            style: TextStyle(
              color: myTheme.colorScheme.primary,
            ),
          ),
          Text('${noticia.source.name}. '),
        ],
      ),
    );
  }
}
