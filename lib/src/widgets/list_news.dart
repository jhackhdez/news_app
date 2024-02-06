import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/theme/theme.dart';

class ListNews extends StatelessWidget {
  final List<Article> news;

  const ListNews(this.news, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (BuildContext context, int index) {
        return _News(
          news: news[index],
          index: index,
        );
      },
    );
  }
}

class _News extends StatelessWidget {
  final Article news;
  final int index;
  const _News({required this.news, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(news, index),
        _TarjetaTitulo(news),
        _TarjetaImagen(news)
      ],
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article news;

  const _TarjetaImagen(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Hola Mundo'),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article news;

  const _TarjetaTitulo(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        news.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article news;
  final int index;

  const _TarjetaTopBar(this.news, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Text(
              '${index + 1}. ',
              style: TextStyle(color: myTheme.highlightColor),
            ),
            Text('${news.source.name}. ')
          ],
        ));
  }
}
