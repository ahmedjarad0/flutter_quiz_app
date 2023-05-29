import 'package:flutter/cupertino.dart';
import 'package:flutter_quiz_app/database/controller/question_db_controller.dart';
import 'package:flutter_quiz_app/database/module/question.dart';
import 'package:flutter_quiz_app/database/sql_helper.dart';
import 'package:flutter_quiz_app/utils/process_response.dart';

class QuestionProvider extends ChangeNotifier {
  List<Question> questionItems = <Question>[];
  final SQLHelper sqlHelper = SQLHelper();
 bool loading = false ;
  Future<ProcessResponse> create(Question question) async {
    int newRowId = await SQLHelper.createItem(
        question.question,
        question.firstQuestion,
        question.secondQuestion,
        question.thirdQuestion,
        question.fourthQuestion,
        question.correctAnswer);
    if (newRowId != 0) {
      question.id = newRowId;
      questionItems.add(question);
      notifyListeners();
    }
    return getResponse(newRowId != 0);
  }

  void read() async {
    loading = true ;
    questionItems = (await SQLHelper.read());
    loading = false;
    notifyListeners();
  }

  Future<ProcessResponse> delete(int index) async {
    bool deleted = await SQLHelper.deleteItem(questionItems[index].id);
    if (deleted) {
      questionItems.removeAt(index);
      notifyListeners();
    }
    return getResponse(deleted);
  }

  Future<ProcessResponse> update(Question question) async {
    bool updated = await SQLHelper.update(question);
    if (updated) {
      int index =
          questionItems.indexWhere((element) => element.id == question.id);
      if (index != -1) {
        questionItems[index] = question;
        notifyListeners();
      }
    }
    return getResponse(updated);
  }



  ProcessResponse getResponse(bool success) {
    return ProcessResponse(
        message: success ? 'Operation Successfully' : 'Operation Failed',
        success: success);
  }
}
