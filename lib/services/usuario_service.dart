import '../models/usuario.dart'; import 'database_service.dart';
class UsuarioService { UsuarioService(this._databaseService); final DatabaseService _databaseService;
  Future<bool> cadastrar(Usuario usuario) async { final db = await _databaseService.database; final existente = await db.query('usuarios', where: 'email = ?', whereArgs: [usuario.email]); if (existente.isNotEmpty) return false; await db.insert('usuarios', usuario.toMap()); print('INSERT → Usuário cadastrado: ${usuario.nome}'); return true; }
  Future<Usuario?> login(String email, String senha) async { final db = await _databaseService.database; print('SELECT → Procurando usuário: $email'); final rows = await db.query('usuarios', where: 'email = ? AND senha = ?', whereArgs: [email, senha]); if (rows.isEmpty) { print('SELECT → Usuário não encontrado'); return null; } final usuario = Usuario.fromMap(rows.first); print('SELECT → Usuário encontrado: ${usuario.nome}'); return usuario; }
}
