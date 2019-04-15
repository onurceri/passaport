    
import 'dart:async';
import 'dart:io';
import 'package:passaport/models/application_identity.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
    return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "PassaportDB.db");
    
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE ApplicationIdentity ("
          "id INTEGER PRIMARY KEY,"
          "nickname TEXT,"
          "accUsername TEXT,"
          "accDisplayImage TEXT,"
          "password TEXT"
          ")");
    });
  }

  Future<int> newApplicationIdentity(ApplicationIdentity newIdentity) async {
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM ApplicationIdentity");
    int id = table.first["id"];
    if(id == null){ id= 1; }
    var res = await db.rawInsert(
      "INSERT INTO ApplicationIdentity (id,nickname,accUsername,accDisplayImage,password)"
      " VALUES ($id,'${newIdentity.nickname}',"
               "'${newIdentity.accUsername}','${newIdentity.accDisplayImage}','${newIdentity.password}')");
    return res;
  }

  Future<ApplicationIdentity> getApplicationIdentity(int id) async {
    final db = await database;
    var res =await  db.query("ApplicationIdentity", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? ApplicationIdentity.fromJson(res.first) : Null ;
  }

   Future<List<ApplicationIdentity>> getAllApplicationIdentities() async {
    final db = await database;
    var res = await db.query("ApplicationIdentity");
    List<ApplicationIdentity> list =
        res.isNotEmpty ? res.map((c) => ApplicationIdentity.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> updateApplicationIdentity(ApplicationIdentity newApplicationIdentity) async {
    final db = await database;
    var res = await db.update("ApplicationIdentity", newApplicationIdentity.toJson(),
        where: "id = ?", whereArgs: [newApplicationIdentity.id]);
    return res;
  }

  Future<int> deleteApplicationIdentity(int id) async {
    final db = await database;
    db.delete("ApplicationIdentity", where: "id = ?", whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from ApplicationIdentity");
  }
}

