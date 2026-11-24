import '../models/produto.dart';
import '../services/produto_service.dart';

class ProdutoProvider {
  ProdutoProvider(this._service);
  final ProdutoService _service;
  Future<void> cadastrar(Produto produto) => _service.cadastrar(produto);
  Future<List<Produto>> listar() => _service.listar();
  Future<void> atualizarQuantidade(Produto produto, int quantidade) =>
      _service.atualizarQuantidade(produto, quantidade);
  Future<void> excluir(Produto produto) => _service.excluir(produto);
  Future<void> mostrarProdutosNoTerminal() =>
      _service.mostrarProdutosNoTerminal();
}
