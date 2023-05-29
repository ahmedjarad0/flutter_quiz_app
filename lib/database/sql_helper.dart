import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'module/question.dart';

class SQLHelper {
  late Database database;

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE questions(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        questions TEXT,
        answerOne TEXT,
        answerTwo TEXT,
        answerThree TEXT,
        answerFour TEXT,
        answerCorrect TEXT
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'AUG.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (questions)
  static Future<int> createItem(
      String questions,
      String answerOne,
      String answerTwo,
      String answerThree,
      String answerFour,
      String answerCorrect) async {
    final db = await SQLHelper.db();
    final data = {
      'questions': questions,
      'answerOne': answerOne,
      'answerTwo': answerTwo,
      'answerThree': answerThree,
      'answerFour': answerFour,
      'answerCorrect': answerCorrect,
    };
    final id = await db.insert('questions', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (questions)
  static Future<List<Question>> read() async {
    final db = await SQLHelper.db();
    List<Map<String, dynamic>> rowsMap =
        await db.query('questions', orderBy: "id");
    return rowsMap.map((rowMap) => Question.fromMap(rowMap)).toList();
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('questions', orderBy: "id");
  }

  // Read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return await db.query('questions',
        where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Delete
  static Future<bool> deleteItem(int id) async {
    final db = await SQLHelper.db();

    int deleted =
        await db.delete("questions", where: "id = ?", whereArgs: [id]);
    return deleted != 0;
  }





  static update(Question question) {}
}
