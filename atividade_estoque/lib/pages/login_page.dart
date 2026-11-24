import 'package:flutter/material.dart';

import '../main.dart';
import 'cadastro_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _senha = TextEditingController();
  bool _loading = false;
  @override
  void dispose() {
    _email.dispose();
    _senha.dispose();
    super.dispose();
  }

  Future<void> _entrar() async {
    if (_email.text.trim().isEmpty || _senha.text.isEmpty) {
      _mensagem('Preencha e-mail e senha.');
      return;
    }
    setState(() => _loading = true);
    final usuario = await usuarioProvider.login(
      _email.text.trim(),
      _senha.text,
    );
    if (!mounted) return;
    setState(() => _loading = false);
    if (usuario == null) {
      _mensagem('E-mail ou senha incorretos.');
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage(usuario: usuario)),
      );
    }
  }

  void _mensagem(String texto) =>
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(texto)));
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('ÁREA RESTRITA'), centerTitle: true),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.inventory_2_outlined, size: 72),
              const SizedBox(height: 24),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _senha,
                obscureText: true,
                onSubmitted: (_) => _entrar(),
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _loading ? null : _entrar,
                child: Text(_loading ? 'ENTRANDO...' : 'ENTRAR'),
              ),
              const SizedBox(height: 12),
              const Text(
                'Ainda não possui conta?',
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CadastroPage()),
                ),
                child: const Text('CRIAR CONTA'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
