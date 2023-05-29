import 'package:flutter_quiz_app/database/module/question.dart';
import 'package:flutter_quiz_app/database/sql_helper.dart';
import 'package:sqflite/sqflite.dart';

import '../db_controller.dart';

class QuestionDbController {
  final Database database = DbController().database;
 final SQLHelper sqlHelper = SQLHelper();
  Future<int> create(Question question) async {
    // return await database.rawInsert(
    //     'INSERT INTO questions (question, first_question, second_question, third_question, fourth_question, five_question) VALUES (?, ?, ?, ?, ?, ?)',
    //     [
    //       question.question,
    //       question.firstQuestion,
    //       question.secondQuestion,
    //       question.thirdQuestion,
    //       question.fourthQuestion,
    //       question.fiveQuestion,
    //     ]);
    return await database.insert(Question.tableName, question.toMap());
  }

  Future<bool> delete(int id) async {
    return await database
            .delete(Question.tableName, where: 'id = ?', whereArgs: [id]) !=
        0;
  }

  Future<List<Question>> read() async {
    List<Map<String, dynamic>> rowMap =
        await database.query(Question.tableName);
    return rowMap.map((rowMaps) => Question.fromMap(rowMaps)).toList();
  }

  Future<bool> update(Question question) async {

    return await database.update(Question.tableName, question.toMap(),
            where: 'id = ?', whereArgs: [question.id]) != 0;
  }
}
