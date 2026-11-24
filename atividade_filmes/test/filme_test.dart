import 'package:atividade_filmes/models/filme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('converte o status SQLite entre inteiro e booleano', () {
    final filme = Filme.fromMap(const {
      'id': 1,
      'titulo': 'Interestelar',
      'assistido': 1,
    });

    expect(filme.assistido, isTrue);
    expect(filme.copyWith(assistido: false).toMap()['assistido'], 0);
  });
}
