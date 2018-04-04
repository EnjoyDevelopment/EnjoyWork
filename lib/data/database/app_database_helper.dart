import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import 'database_open_helper.dart';
import 'model/user_state.dart';
import 'tables.dart';

class AppDatabaseHelper implements DatabaseHelper {
  static final AppDatabaseHelper _instance = new AppDatabaseHelper.internal();
  factory AppDatabaseHelper() => _instance;
  static Database _db;

  //named constructor
  AppDatabaseHelper.internal();

  Future<Database> get database async {
    if (_db != null) {
      return _db;
    }

    var dataBaseOpenHelper = new DatabaseOpenHelper();
    _db = await dataBaseOpenHelper.initDatabase();
    return _db;
  }

  @override
  Future<void> saveUserState(UserState userState) async {
    var dbClient = await database;
    await dbClient.insert(Tables.userStateTable, userState.toMap());
  }

  @override
  Future<int> deleteUserState(UserState userState) async {
    var dbClient = await database;
    int response = await dbClient.delete(Tables.userStateTable);
    return response;
  }

  @override
  Future<List<Map<String, String>>> retrieveUserState() async {
    var dbClient = await database;
    List<Map> list =
        await dbClient.rawQuery("SELECT * FROM  ${Tables.userStateTable}");
    return list;
  }
}
