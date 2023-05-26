import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/product.dart';

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

  //Veri tabanından alınan verileri listeye dönüştürme
  Future<List<Product>> getProducts() async {
    Database db = await this.db;
    var result = await db.query("products");
    //product içinde oluşturduğumuz fromObject constructoru teker teker map'ten aldığı alanları ayırıp buraya atıyo ve bu List.generator da bunu listeye çeviriyor.
    return List.generate(result.length, (i) {
      return Product.fromObject(result[i]);
    });
  }

  Future<int> insert(Product product) async {
    Database db = await this.db;

    var result = await db.insert("products", product.toMap());

    return result;
  }

  Future<int> delete(Product product) async {
    Database db = await this.db;

    var result =
        await db.delete("products", where: "id=?", whereArgs: [product.id]);

    return result;
  }

  Future<int> update(Product product) async {
    Database db = await this.db;

    var result = await db.update("products", product.toMap(),
        where: "id=?", whereArgs: [product.id]);

    return result;
  }
}
