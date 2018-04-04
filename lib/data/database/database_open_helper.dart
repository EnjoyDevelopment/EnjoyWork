import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../helper/constants.dart';

class DatabaseOpenHelper {
  initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    print(documentsDirectory);

    String path = join(documentsDirectory.path, Constants.DATABASE_NAME);

    // make sure the folder exists
    if (await new Directory(dirname(path)).exists()) {
      await deleteDatabase(path);
    } else {
      try {
        await new Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
        //todo error
      }
    }

    Database db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE UserState(id INTEGER PRIMARY KEY, emotionmessage TEXT, emotionstate TEXT, timestamp TEXT)");
    print("table created");
  }
}
