import 'package:flutter/foundation.dart';

import '../models/filme.dart';
import '../services/filme_service.dart';

class FilmeViewModel extends ChangeNotifier {
  FilmeViewModel(this._service);
  final FilmeService _service;
  List<Filme> _filmes = [];
  bool _carregando = false;
  List<Filme> get filmes => List.unmodifiable(_filmes);
  bool get carregando => _carregando;
  Future<void> carregarFilmes() async {
    _carregando = true;
    notifyListeners();
    try {
      _filmes = await _service.listarFilmes();
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  Future<void> adicionarFilme(String titulo) async {
    final limpo = titulo.trim();
    if (limpo.isEmpty) throw const FormatException('Digite o nome do filme.');
    await _service.inserirFilme(Filme(titulo: limpo, assistido: false));
    await carregarFilmes();
  }

  Future<void> alterarAssistido(Filme filme, bool assistido) async {
    await _service.atualizarStatus(filme.copyWith(assistido: assistido));
    await carregarFilmes();
  }
}
