import 'package:atividade_estoque/models/produto.dart';
import 'package:atividade_estoque/models/usuario.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('converte usuário entre objeto e mapa', () {
    final usuario = Usuario.fromMap(const {
      'id': 1,
      'nome': 'Maria',
      'email': 'maria@email.com',
      'senha': '1234',
    });

    expect(usuario.nome, 'Maria');
    expect(usuario.toMap()['email'], 'maria@email.com');
  });

  test('converte preço e quantidade do produto', () {
    final produto = Produto.fromMap(const {
      'id': 1,
      'nome': 'Teclado',
      'categoria': 'Informática',
      'quantidade': 3,
      'preco': 250,
    });

    expect(produto.quantidade, 3);
    expect(produto.preco, 250.0);
  });
}
