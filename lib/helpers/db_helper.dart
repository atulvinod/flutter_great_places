import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> getDatabase() async {
    // To get the database path of the OS
    final dbPath = await sql.getDatabasesPath();
    //Opens a connection to the database.
    //If it doesnt find a database, then it creates a database at the location
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      //Executed when the database is being created
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT, image TEXT');
    });
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDb = await DBHelper.getDatabase();
    // Now that our database is created, we can insert data into the database
    // Conflict Algorithmn determines how to handle the situation when the id of the
    // entity being inserted into the table already exists
    await sqlDb.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.getDatabase();
    return db.query(table);
  }
}
