import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:news_app/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          _ListaCategorias(),
          Expanded(
              child: ListNews(newService.getArticulosCategoriaSeleccionada))
        ],
      )),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Acá se carga la lista de categorías definida en el servicio
    final categories = Provider.of<NewsService>(context).categories;

    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
          // esta propiedad permite que se mire igual en Android y iOS
          physics: const BouncingScrollPhysics(),
          // se adiciona scroll horizontal
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            final cName = categories[index].name;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  // '_CategoryButton' para personalización del ícono que se muestra en un widget independiente
                  _CategoryButton(categories[index]),
                  const SizedBox(height: 5),
                  // Para capitalizar el nombre de las categorías
                  Text('${cName[0].toUpperCase()}${cName.substring(1)}')
                ],
              ),
            );
          }),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    // 'GestureDetector' maneja la acci'on al hacer clic en el ícono
    return GestureDetector(
      onTap: () {
        // print('Hola Mundo');
        // En los eventos 'onTab' cuando se acede al context la propiedad 'listen: false'
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(category.icon,
            color: (newsService.selectedCategory == category.name)
                ? myTheme.canvasColor
                : Colors.black54),
      ),
    );
  }
}
