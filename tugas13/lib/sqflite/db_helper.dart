// import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:tugas13/model/user.dart';
import 'package:tugas13/model/belanja.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Future<Database> databaseHelper() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'Daftar.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE daftar(id INTEGER PRIMARY KEY, username TEXT, email TEXT, password TEXT)',
        );

        await db.execute(
          'CREATE TABLE shoppingItem(id INTEGER PRIMARY KEY, nama TEXT, kategori TEXT, catatan TEXT)',
        );
      },
      version: 2,
    );
  }

  static Future<void> insertPengguna(User pengguna) async {
    final db = await databaseHelper();
    await db.insert(
      'daftar',
      pengguna.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<User?> loginUser(String email, String password) async {
    final db = await databaseHelper();
    final List<Map<String, dynamic>> results = await db.query(
      'daftar',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (results.isNotEmpty) {
      return User.fromMap(results.first);
    }
    return null;
  }

  static Future<List<User>> getAllPengguna() async {
    final db = await databaseHelper();
    final List<Map<String, dynamic>> maps = await db.query('daftar');
    return List.generate(maps.length, (i) => User.fromMap(maps[i]));
  }

  static Future<void> insertShoppingItem(ShoppingItem shoppingitem) async {
    final db = await databaseHelper();
    await db.insert(
      'shoppingItem',
      shoppingitem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<ShoppingItem>> getAllShoppingItem() async {
    final db = await databaseHelper();
    final List<Map<String, dynamic>> results = await db.query('shoppingItem');
    return results.map((e) => ShoppingItem.fromMap(e)).toList();
  }

  static Future<void> updateShoppingItem(ShoppingItem shoppingitem) async {
    final db = await databaseHelper();
    await db.update(
      'shoppingItem',
      shoppingitem.toMap(),
      where: "id = ?",
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteShoppingItem(int id) async {
    final db = await databaseHelper();
    await db.delete('shoppingitem', where: "id = ?", whereArgs: [id]);
  }
}
