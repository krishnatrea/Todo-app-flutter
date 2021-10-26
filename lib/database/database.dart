import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/models/todo.dart';

class CustomDb {
  Database? _db;

  CustomDb._cont();

  static final CustomDb instance = CustomDb._cont();

  Future<Database> get database async {
    if (_db == null) {
      return await opendatabase();
    }
    return _db!;
  }

  Future<void> deletetodo(String id) async {
    final db = await database;
    await db.delete(
      'todo',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertTodo(Tododata todo) async {
    final db = await database;
    await db.insert(
      'todo',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Tododata>> todolist() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todo');
    return List.generate(maps.length, (i) {
      return Tododata.fromMap(maps[i]);
    });
  }

  Future<void> updateTodo(Tododata todo) async {
    final db = await database;

    await db.update(
      'todo',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  opendatabase() async {
    return openDatabase(
      join(
        await getDatabasesPath(),
        'datadb.db',
      ),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE todo
          (id TEXT PRIMARY KEY, 
          title TEXT,
          description TEXT,
          catagory TEXT,
          done INTEGER,
          createdAt TEXT,
          deleted INTEGER)
          ''',
        );
      },
      version: 1,
    );
  }
}
