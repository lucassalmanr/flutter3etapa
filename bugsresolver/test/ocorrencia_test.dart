import 'package:flutter_test/flutter_test.dart';
import 'package:central_achados/models/ocorrencia.dart';

void main() {
  group('Ocorrencia.fromMap', () {
    test('preserva o uid e o status armazenados', () {
      final ocorrencia = Ocorrencia.fromMap('caso-1', {
        'titulo': 'Mochila',
        'local': 'Biblioteca',
        'descricao': 'Azul',
        'autorId': 'uid-123',
        'autorNome': 'Ana',
        'resolvido': true,
      });

      expect(ocorrencia.id, 'caso-1');
      expect(ocorrencia.autorId, 'uid-123');
      expect(ocorrencia.autorNome, 'Ana');
      expect(ocorrencia.resolvido, isTrue);
    });

    test('aplica padrões seguros quando campos opcionais não existem', () {
      final ocorrencia = Ocorrencia.fromMap('caso-2', const {});

      expect(ocorrencia.autorNome, 'Anônimo');
      expect(ocorrencia.resolvido, isFalse);
      expect(ocorrencia.criadoEm, isNull);
    });
  });
}
