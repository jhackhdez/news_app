import 'package:flutter/material.dart';
import 'package:news_app/src/pages/tabs_page.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:provider/provider.dart';

import 'src/services/news_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Este 'MultiProvider' permite utilizar el 'ChangeNotifierProvider' para posicionar
    // 'NewsService' en el top del arbol de widgets y poder utilizarlo
    // en cualquier parte de la app donde lo necesite
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NewsService())],
      child: MaterialApp(
          title: 'Material App',
          theme: myTheme,
          debugShowCheckedModeBanner: false,
          home: const TabsPage()),
    );
  }
}
