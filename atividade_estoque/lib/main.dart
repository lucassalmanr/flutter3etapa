import 'package:flutter/material.dart';

import 'pages/login_page.dart';
import 'providers/produto_provider.dart';
import 'providers/usuario_provider.dart';
import 'services/database_service.dart';
import 'services/produto_service.dart';
import 'services/usuario_service.dart';

final databaseService = DatabaseService();
final usuarioProvider = UsuarioProvider(UsuarioService(databaseService));
final produtoProvider = ProdutoProvider(ProdutoService(databaseService));

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ControleEstoqueApp());
}

class ControleEstoqueApp extends StatelessWidget {
  const ControleEstoqueApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Controle de Estoque',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    ),
    home: const LoginPage(),
  );
}
