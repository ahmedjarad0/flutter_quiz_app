import 'dart:io';
import 'package:flutter_quiz_app/database/module/question.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbController {
  late Database _database;

  DbController._();

  static DbController? _instance;

  factory DbController() {
    return _instance ??= DbController._();
  }

  Database get database => _database;

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'quizApp.sql');
    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE questions('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'question TEXT NOT NULL,'
            'first_question TEXT NOT NULL,'
            'second_question TEXT NOT NULL,'
            'third_question TEXT NOT NULL,'
            'fourth_question TEXT NOT NULL'
            ')');
      },
    );
  }
}
