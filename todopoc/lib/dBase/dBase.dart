import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todopoc/models/stuClass.dart';

class DBHelper {
  static final _databaseName = 'todo.db';
  static final _tasks_table = 'tasks_table';
  static final _databaseVersion = 1;
  static Database? _database;
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    String path = join(await getDatabasesPath(), _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $_tasks_table('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING, clgname STRING, branch STRING, year STRING'
        ')');
  }

  Future<int> insertTask(StuClass stuClass) async {
    Database? db = await DBHelper._database;
    return await db!.insert(_tasks_table, {
      'name': stuClass.name,
      'clgname': stuClass.clgname,
      'branch': stuClass.branch,
      'year': stuClass.year,
    });
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = DBHelper._database;
    return await db!.query(_tasks_table);
  }


  Future<int> delete(int id) async {
    Database? db = await DBHelper._database;
    return await db!.delete(_tasks_table, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllTasks() async {
    Database? db = await DBHelper._database;
    return await db!.delete(_tasks_table);
  }
}
