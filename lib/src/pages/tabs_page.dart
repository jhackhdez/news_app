import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tab1_page.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Se crea un "ChangeNotifierProvider" siguiendo el modelo "_NavigationModel"
    // Esto sería una instacia global
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

// Este widget se encarga de la navegación en el footer
class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Este "context" almacena la información de todo el arbol de widget, por tanto tiene la instacia del provider
    // Se obtiene esta instacia
    final navegationModel = Provider.of<_NavigationModel>(context);
    return BottomNavigationBar(
        // Permite cambiar opción seleccionada desde íconos del footer
        currentIndex: navegationModel.paginaActual,
        // "index" sería el valor entero del ícono seleccionado en el footer
        onTap: (index) => navegationModel.paginaActual = index,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Para ti'),
          BottomNavigationBarItem(
              icon: Icon(Icons.public), label: 'Encabezados')
        ]);
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Acceso al provider
    final navegacionModel = Provider.of<_NavigationModel>(context);
    return PageView(
      // Acceder a la propiedad que maneja las páginas
      controller: navegacionModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Tab1Page(),
        Container(
          color: Colors.green,
        )
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _paginaActual = 0;
  // "_pageController" se encargará de mostrar la página según selección
  final PageController _pageController = PageController();

// No se define provado este get para poder acceder a él desde cualquier widgets
// y saber el estado de la variable: _paginaActual
  int get paginaActual => _paginaActual;

  set paginaActual(int valor) {
    _paginaActual = valor;
    // Esta línea maneja el cambio de página con la animación
    _pageController.animateToPage(valor,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    // Notificar a todos los widgets necesarios para que se redibujen
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
