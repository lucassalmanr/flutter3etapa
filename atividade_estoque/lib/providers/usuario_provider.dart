import '../models/usuario.dart';
import '../services/usuario_service.dart';

class UsuarioProvider {
  UsuarioProvider(this._service);
  final UsuarioService _service;
  Future<bool> cadastrar(Usuario usuario) => _service.cadastrar(usuario);
  Future<Usuario?> login(String email, String senha) =>
      _service.login(email, senha);
}
