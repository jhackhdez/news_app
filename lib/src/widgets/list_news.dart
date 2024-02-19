import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/theme/theme.dart';

class ListNews extends StatelessWidget {
  final List<Article> news;

  const ListNews(this.news);

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
        _TarjetaImagen(news),
        _TarjetaBody(news),
        _TarjetaBotones(),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // RawMaterialButton otra clase de botones
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.star_border),
        ),
        const SizedBox(width: 10),
        // RawMaterialButton otra clase de botones
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.more),
        )
      ],
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article news;
  const _TarjetaBody(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text((news.description != null) ? '${news.description}' : ''),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article news;
  const _TarjetaImagen(this.news);

  @override
  Widget build(BuildContext context) {
    // ClipRRect crea el borde redondeado en la imagen
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
            // Condición ternaria para mostrar imagen de 'no-image' si en la noticia no viene una imagen de cabecera
            child: (news.urlToImage != null)
                ? FadeInImage(
                    placeholder: const AssetImage('assets/img/giphy.gif'),
                    image: NetworkImage('${news.urlToImage}'))
                : const Image(image: AssetImage('assets/img/no-image.png'))),
      ),
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
              style: TextStyle(color: myTheme.hintColor),
            ),
            Text('${news.source.name}. ')
          ],
        ));
  }
}
