import 'package:flutter/material.dart';

import '../models/usuario.dart';
import 'cadastro_produto_page.dart';
import 'estoque_page.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.usuario});

  final Usuario usuario;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('CONTROLE DE ESTOQUE'),
      automaticallyImplyLeading: false,
    ),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Olá, ${usuario.nome}!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EstoquePage()),
                ),
                icon: const Icon(Icons.list_alt),
                label: const Text('VER PRODUTOS'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CadastroProdutoPage(),
                  ),
                ),
                icon: const Icon(Icons.add_box_outlined),
                label: const Text('CADASTRAR PRODUTO'),
              ),
              const SizedBox(height: 28),
              TextButton.icon(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (_) => false,
                ),
                icon: const Icon(Icons.logout),
                label: const Text('SAIR'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
