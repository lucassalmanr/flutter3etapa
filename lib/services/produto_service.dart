import '../models/produto.dart'; import 'database_service.dart';
class ProdutoService { ProdutoService(this._databaseService); final DatabaseService _databaseService;
  Future<void> cadastrar(Produto produto) async { final db = await _databaseService.database; await db.insert('produtos', produto.toMap()); print('INSERT → Produto cadastrado: ${produto.nome}'); }
  Future<List<Produto>> listar() async { final db = await _databaseService.database; final rows = await db.query('produtos', orderBy: 'nome COLLATE NOCASE'); print('SELECT → Produtos encontrados:'); for (final row in rows) { print(row); } return rows.map(Produto.fromMap).toList(); }
  Future<void> atualizarQuantidade(Produto produto, int quantidade) async { final db = await _databaseService.database; await db.update('produtos', {'quantidade': quantidade}, where: 'id = ?', whereArgs: [produto.id]); print('UPDATE → ${produto.nome}\nQuantidade anterior: ${produto.quantidade}\nNova quantidade: $quantidade'); }
  Future<void> excluir(Produto produto) async { final db = await _databaseService.database; await db.delete('produtos', where: 'id = ?', whereArgs: [produto.id]); print('DELETE → Produto excluído: ${produto.nome}'); }
  Future<void> mostrarProdutosNoTerminal() async { final db = await _databaseService.database; final produtos = await db.query('produtos'); print('===== PRODUTOS NO BANCO ====='); for (final produto in produtos) { print(produto); } }
}
