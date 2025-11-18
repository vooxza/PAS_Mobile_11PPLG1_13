import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pas_mobile_11pplg1_13/models/product_model.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'contacts.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)',
        );
        await db.execute(
          'CREATE TABLE favorites(id INTEGER PRIMARY KEY, product TEXT)',
        );
      },
    );
  }

  Future<int> insertName(String name) async {
    final client = await db;
    return client.insert('contacts', {'name': name});
  }

  Future<int> insertFavorite(ProductModel product) async {
    final client = await db;
    // store product as JSON text; use product id as primary key so insert/update replaces
    return client.insert(
      'favorites',
      {'id': product.id, 'product': jsonEncode(product.toJson())},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Map<String, dynamic>>> getNames() async {
    final client = await db;
    return client.query('contacts', orderBy: 'id DESC');
  }

  Future<List<ProductModel>> getFavorites() async {
    final client = await db;
    final rows = await client.query('favorites', orderBy: 'id DESC');
    return rows.map((r) {
      final productJson = r['product'] as String? ?? '{}';
      final Map<String, dynamic> map = jsonDecode(productJson);
      return ProductModel.fromJson(map);
    }).toList();
  }

  Future<int> deleteName(int id) async {
  final client = await db;
  return await client.delete(
    'contacts',
    where: 'id = ?',
    whereArgs: [id],
  );
}
  Future<int> deleteFavoriteById(int id) async {
    final client = await db;
    return await client.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<int> updateName(int id, String newName) async {
    final client = await db;
    return await client.update(
      'contacts',
      {'name': newName},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
