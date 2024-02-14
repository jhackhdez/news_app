import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

// Este widget se define como un 'StatefulWidget' para no destruir el estado del mismo, o sea
// si hago scroll en TabPage1 luego salto a TabPage2, cuando regrese a TabPage1 se mantine
// la misma posición y/o noticia en la que se había dejado al hacer scroll.
class Tab1Page extends StatefulWidget {
  const Tab1Page({super.key});

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

// 'AutomaticKeepAliveClientMixin' se adiciona al pasar el widget como 'StatefulWidget'
class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final headLines = Provider.of<NewsService>(context).headLines;

    // Condición que muestra en loading
    return Scaffold(
        body: (headLines.isEmpty)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListNews(headLines));
  }

  @override
  bool get wantKeepAlive => true;
}
