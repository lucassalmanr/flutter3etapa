import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
class DatabaseService {
  Database? _database; Future<Database>? _opening;
  Future<Database> get database => _database != null ? Future.value(_database!) : (_opening ??= _open());
  Future<Database> _open() async { final db = await databaseFactoryFfiWeb.openDatabase('controle_estoque.db', options: OpenDatabaseOptions(version: 1, onCreate: (db, _) => _createTables(db))); await _createTables(db); _database = db; return db; }
  Future<void> _createTables(DatabaseExecutor db) async {
    await db.execute('CREATE TABLE IF NOT EXISTS usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, email TEXT NOT NULL UNIQUE, senha TEXT NOT NULL)');
    await db.execute('CREATE TABLE IF NOT EXISTS produtos (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, categoria TEXT NOT NULL, quantidade INTEGER NOT NULL, preco REAL NOT NULL)');
  }
}
