import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import '../models/filme.dart';

/// Centraliza o acesso ao SQLite; a interface não conversa com o banco.
class FilmeService {
  static const _nomeBanco = 'filmes.db';
  static const _tabela = 'filmes';
  Database? _database;
  Future<Database>? _abertura;
  Future<Database> get _db async => _database ??= await (_abertura ??= _abrirBanco());
  Future<Database> _abrirBanco() async => databaseFactoryFfiWeb.openDatabase(_nomeBanco, options: OpenDatabaseOptions(version: 1, onCreate: (db, version) => db.execute('CREATE TABLE $_tabela (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT NOT NULL, assistido INTEGER NOT NULL)')));
  Future<void> inserirFilme(Filme filme) async => (await _db).insert(_tabela, filme.toMap());
  Future<List<Filme>> listarFilmes() async => (await (await _db).query(_tabela, orderBy: 'id ASC')).map(Filme.fromMap).toList();
  Future<void> atualizarStatus(Filme filme) async => (await _db).update(_tabela, {'assistido': filme.assistido ? 1 : 0}, where: 'id = ?', whereArgs: [filme.id]);
}
