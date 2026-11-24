import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/pagina_inicial.dart';
import 'services/filme_service.dart';
import 'viewmodels/filme_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MinhaListaDeFilmesApp());
}

class MinhaListaDeFilmesApp extends StatelessWidget {
  const MinhaListaDeFilmesApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (_) => FilmeViewModel(FilmeService())..carregarFilmes(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minha Lista de Filmes',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: const PaginaInicial(),
    ),
  );
}
