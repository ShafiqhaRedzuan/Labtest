import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteDB {
  static const String _dbName = "bitp3453_bmi";

  Database? _db;

  SQLiteDB._(); //private constructor
  static final SQLiteDB _instance = SQLiteDB._();

  factory SQLiteDB(){
    return _instance;
  }

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    String path = join(await getDatabasesPath(), _dbName,);
    _db =
    await openDatabase(path, version: 1, onCreate: (createDb, version) async {
      for (String tableSql in SQLiteDB.tableSQLStrings) {
        await createDb.execute(tableSql);
      }
    },);
    return _db!;
  }

  static List<String> tableSQLStrings =
  [
    '''
          CREATE TABLE IF NOT EXISTS bmi (id INTEGER PRIMARY KEY AUTOINCREMENT,
          username VARCHAR,
          weight DOUBLE,
          height DOUBLE,
          gender VARCHAR
          bmi_status VARCHAR)
        ''',
  ];
}