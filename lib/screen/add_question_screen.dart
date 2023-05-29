import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/database/module/question.dart';
import 'package:flutter_quiz_app/database/sql_helper.dart';
import 'package:flutter_quiz_app/provider/question_provider.dart';
import 'package:flutter_quiz_app/utils/extintion_helper.dart';
import 'package:flutter_quiz_app/utils/process_response.dart';
import 'package:flutter_quiz_app/widgets/app_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class AddQuestionScreen extends StatefulWidget {
  const AddQuestionScreen({Key? key}) : super(key: key);

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController firstEditingController = TextEditingController();
  TextEditingController secondEditingController = TextEditingController();
  TextEditingController thirdEditingController = TextEditingController();
  TextEditingController fourthEditingController = TextEditingController();
  String? correctAnswer;

  String valueDrop = 'A';


  final List<String> _answer = <String>['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new question')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                TextField(
                  controller: textEditingController,
                  keyboardType: TextInputType.text,
                  expands: false,
                  minLines: 1,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Enter the question',
                    hintStyle: const TextStyle(color: Colors.grey),
                    labelText: 'Question',
                    prefixIcon: const Icon(
                      Icons.question_mark,
                      color: Colors.teal,
                    ),
                    labelStyle: GoogleFonts.poppins(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.teal)),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text('A'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: AppTextField(
                            label: 'First question',
                            controller: firstEditingController)),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      child: Text('B'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: AppTextField(
                            label: 'Second question',
                            controller: secondEditingController)),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.yellow,
                      child: Text('C'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: AppTextField(
                            label: 'Third question',
                            controller: thirdEditingController)),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: Text('D'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: AppTextField(
                            label: 'Fourth question',
                            controller: fourthEditingController)),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      'Select the correct answer',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    const Spacer(),
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: valueDrop,
                        onChanged: (value) {
                          if (value == _answer[0]) {
                            correctAnswer = firstEditingController.text;
                            valueDrop = 'A';
                          } else if (value == _answer[1]) {
                            correctAnswer = secondEditingController.text;
                            valueDrop = 'B';
                          } else if (value == _answer[2]) {
                            correctAnswer = thirdEditingController.text;
                            valueDrop = 'C';
                          } else if (value == _answer[3]) {
                            correctAnswer = fourthEditingController.text;
                            valueDrop = 'D';
                          }

                          setState(() {});

                          print('value :$value');
                          print('correctAnswer :$correctAnswer');
                        },
                        items: _answer
                            .map((e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Center(
                                      child: Text(
                                    e,
                                    style:
                                        GoogleFonts.poppins(color: Colors.teal),
                                  )),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    _performAdd();
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.teal),
                  child: const Text('Add question'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _performAdd() {
    if (checkData()) {
      _add();
    }
  }

  bool checkData() {
    if (textEditingController.text.isNotEmpty &&
        firstEditingController.text.isNotEmpty &&
        secondEditingController.text.isNotEmpty &&
        thirdEditingController.text.isNotEmpty &&
        fourthEditingController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'Enter required data', error: true);
    return false;
  }

  void _add() async {
    ProcessResponse processResponse =
        await Provider.of<QuestionProvider>(context, listen: false)
            .create(question);
    if (processResponse.success) {
      Navigator.pushNamed(context, '/create_quiz_screen');
    }
    context.showSnackBar(
        message: processResponse.message, error: !processResponse.success);
  }

  Question get question {
    Question question = Question();
    question.question = textEditingController.text;
    question.firstQuestion = firstEditingController.text;
    question.secondQuestion = secondEditingController.text;
    question.thirdQuestion = thirdEditingController.text;
    question.fourthQuestion = fourthEditingController.text;
    question.correctAnswer = correctAnswer ?? firstEditingController.text;

    return question;
  }
}
