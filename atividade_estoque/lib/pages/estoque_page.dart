import 'package:flutter/material.dart';

import '../main.dart';
import '../models/produto.dart';

class EstoquePage extends StatefulWidget {
  const EstoquePage({super.key});

  @override
  State<EstoquePage> createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  late Future<List<Produto>> _produtos;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  void _carregar() {
    _produtos = produtoProvider.listar();
  }

  Future<void> _recarregar() async {
    setState(_carregar);
    await _produtos;
  }

  Future<void> _alterar(Produto produto, int quantidade) async {
    if (quantidade < 0) return;
    await produtoProvider.atualizarQuantidade(produto, quantidade);
    await _recarregar();
  }

  Future<void> _excluir(Produto produto) async {
    final confirmou = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir produto?'),
        content: Text('Remover ${produto.nome} do estoque?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('CANCELAR'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('EXCLUIR'),
          ),
        ],
      ),
    );
    if (confirmou == true) {
      await produtoProvider.excluir(produto);
      await _recarregar();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('ESTOQUE')),
    body: FutureBuilder<List<Produto>>(
      future: _produtos,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        }

        final produtos = snapshot.data ?? [];
        if (produtos.isEmpty) {
          return const Center(child: Text('Nenhum produto cadastrado.'));
        }

        return RefreshIndicator(
          onRefresh: _recarregar,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: produtos.length,
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (_, i) => _produtoCard(produtos[i]),
          ),
        );
      },
    ),
  );

  Widget _produtoCard(Produto produto) {
    final estoqueBaixo = produto.quantidade <= 3;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(produto.nome, style: Theme.of(context).textTheme.titleLarge),
            Text(produto.categoria),
            const SizedBox(height: 8),
            Text(
              'R\$ ${produto.preco.toStringAsFixed(2).replaceAll('.', ',')}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (estoqueBaixo)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Chip(
                  label: Text('ESTOQUE BAIXO'),
                  avatar: Icon(Icons.warning_amber_rounded),
                ),
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  onPressed: produto.quantidade == 0
                      ? null
                      : () => _alterar(produto, produto.quantidade - 1),
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Expanded(
                  child: Text(
                    'Quantidade: ${produto.quantidade}',
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: () => _alterar(produto, produto.quantidade + 1),
                  icon: const Icon(Icons.add_circle_outline),
                ),
                IconButton(
                  tooltip: 'Excluir',
                  onPressed: () => _excluir(produto),
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
