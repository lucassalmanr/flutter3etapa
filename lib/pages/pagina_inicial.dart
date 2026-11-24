import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/filme.dart';
import '../viewmodels/filme_viewmodel.dart';

class PaginaInicial extends StatefulWidget { const PaginaInicial({super.key}); @override State<PaginaInicial> createState() => _PaginaInicialState(); }
class _PaginaInicialState extends State<PaginaInicial> {
  final _titulo = TextEditingController(); bool _salvando = false;
  @override void dispose() { _titulo.dispose(); super.dispose(); }
  Future<void> _adicionar() async { if (_salvando) return; setState(() => _salvando = true); try { await context.read<FilmeViewModel>().adicionarFilme(_titulo.text); _titulo.clear(); } on FormatException catch (erro) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(erro.message))); } finally { if (mounted) setState(() => _salvando = false); } }
  @override Widget build(BuildContext context) { final vm = context.watch<FilmeViewModel>(); return Scaffold(appBar: AppBar(title: const Text('Minha Lista de Filmes')), body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [TextField(controller: _titulo, textInputAction: TextInputAction.done, onSubmitted: (_) => _adicionar(), decoration: const InputDecoration(labelText: 'Digite o nome do filme', border: OutlineInputBorder())), const SizedBox(height: 12), SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _salvando ? null : _adicionar, child: const Text('Adicionar'))), const Divider(height: 32), Expanded(child: vm.carregando ? const Center(child: CircularProgressIndicator()) : vm.filmes.isEmpty ? const Center(child: Text('Nenhum filme cadastrado.')) : ListView.separated(itemCount: vm.filmes.length, separatorBuilder: (_, __) => const Divider(height: 1), itemBuilder: (_, i) => _item(vm.filmes[i], i + 1)))]))); }
  Widget _item(Filme filme, int numero) => ListTile(leading: Text('$numero'), title: Text(filme.titulo, style: TextStyle(decoration: filme.assistido ? TextDecoration.lineThrough : null)), trailing: Checkbox(value: filme.assistido, onChanged: (valor) { if (valor != null) context.read<FilmeViewModel>().alterarAssistido(filme, valor); }), onTap: () => context.read<FilmeViewModel>().alterarAssistido(filme, !filme.assistido));
}
