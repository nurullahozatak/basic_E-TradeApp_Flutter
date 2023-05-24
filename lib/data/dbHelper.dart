import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  late Database _db;

  Future<Database> get db async {
    if (_db == null) {
      //eğer ki bir veri tabanı daha önceden yoksa oluştur
      _db = await initializeDb();
    }
    //var olan ya da yeni oluşturulan veri tabanını döndür
    return _db;
  }

  Future<Database> initializeDb() async {
    //yeni veri tabanı oluşturma
    String dbPath = join(await getDatabasesPath(), "etrade.db");
    var eTradeDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return eTradeDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table products (id integer primary key, name text, description text, unitPrice ineteger)");
  }
}
