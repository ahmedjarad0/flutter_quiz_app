class Question {
  late int id;
  late String question;
  late String firstQuestion;
  late String secondQuestion;
  late String thirdQuestion;
  late String fourthQuestion;
late String correctAnswer ;
  static const String tableName = 'questions';

  Question();

  /// Read row data from database table
  Question.fromMap(Map<String, dynamic> rowMap) {
    id = rowMap['id'];
    question = rowMap['questions'];
    firstQuestion = rowMap['answerOne'];
    secondQuestion = rowMap['answerTwo'];
    thirdQuestion = rowMap['answerThree'];
    fourthQuestion = rowMap['answerFour'];
    correctAnswer = rowMap['answerCorrect'];
  }

  /// Prepare map to be saved in database

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['questions'] = question;
    map['answerOne'] = firstQuestion;
    map['answerTwo'] = secondQuestion;
    map['answerThree'] = thirdQuestion;
    map['answerFour'] = fourthQuestion;
    map['answerCorrect'] = correctAnswer;
    return map;
  }
}
