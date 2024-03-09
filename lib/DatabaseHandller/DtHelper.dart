import 'package:app/Model/UserModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_handler/database/database_helper.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:app/DatabaseHandller/DtHelper.dart';
import 'dart:io' as io;

class dbhelper {
  Database? _db;
  static const DB_Name = 'test.db';
  static const int version = 4;
  static const String Table_user = 'user';
  static const String userName = 'user_name';
  static const String email = 'email';
  static const String password = 'password';
  dbhelper() {
    initDb();
  }

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: version, onCreate: _oncreate);
    _db = db;
    return db;
  }

  _oncreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $Table_user ($userName TEXT PRIMARY KEY, $password TEXT)');
  }

  Future<UserModel> saveData(UserModel user) async {
    var dbClient = await db;
    int userID = await (await dbClient.insert(Table_user, user.toMap()));
    user.user_name = userID.toString();

    return user;
  }

  Future<UserModel?> getLoginUser(String username, String uPassword) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery(
        'SELECT * FROM $Table_user WHERE $userName=? AND $password=?',
        [username, uPassword]);
    if (res.isNotEmpty) {
      return UserModel.fromMap(res.first);
    }

    return null;
  }
}
