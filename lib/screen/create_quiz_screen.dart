import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/provider/question_provider.dart';
import 'package:flutter_quiz_app/utils/extintion_helper.dart';
import 'package:flutter_quiz_app/utils/process_response.dart';
import 'package:flutter_quiz_app/widgets/check_answer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({Key? key}) : super(key: key);

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
 // List<Map<String, dynamic>> listQs = [];
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<QuestionProvider>(context, listen: false).read();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quiz'),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home_screen');
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_question_screen');
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Colors.teal),
              child: const Text('+    Add new question'),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Consumer<QuestionProvider>(
                      builder: (context, value, child) {
                     if (value.questionItems.isNotEmpty) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: value.questionItems.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Card(
                                  color: Colors.grey.shade200,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  value.questionItems[index]
                                                      .question,
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16)),
                                            ),
                                            // const Spacer(),
                                            IconButton(
                                                onPressed: () {
                                                  _confirmLogoutDialog(index);
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.grey,
                                                )),
                                          ],
                                        ),
                                        CheckAnswer(
                                            color: value.questionItems[index]
                                                        .firstQuestion ==
                                                    value.questionItems[index]
                                                        .correctAnswer
                                                ? Colors.green.shade500
                                                : Colors.white,
                                            textColor: value
                                                        .questionItems[index]
                                                        .firstQuestion ==
                                                    value.questionItems[index]
                                                        .correctAnswer
                                                ? Colors.white
                                                : Colors.black,
                                            title: value.questionItems[index]
                                                .firstQuestion),
                                        CheckAnswer(
                                            color: value.questionItems[index]
                                                        .secondQuestion ==
                                                    value.questionItems[index]
                                                        .correctAnswer
                                                ? Colors.green.shade500
                                                : Colors.white,
                                            textColor: value
                                                        .questionItems[index]
                                                        .secondQuestion ==
                                                    value.questionItems[index]
                                                        .correctAnswer
                                                ? Colors.white
                                                : Colors.black,
                                            title: value.questionItems[index]
                                                .secondQuestion),
                                        CheckAnswer(
                                            color: value.questionItems[index]
                                                        .thirdQuestion ==
                                                    value.questionItems[index]
                                                        .correctAnswer
                                                ? Colors.green.shade500
                                                : Colors.white,
                                            textColor: value
                                                        .questionItems[index]
                                                        .thirdQuestion ==
                                                    value.questionItems[index]
                                                        .correctAnswer
                                                ? Colors.white
                                                : Colors.black,
                                            title: value.questionItems[index]
                                                .thirdQuestion),
                                        CheckAnswer(
                                            color: value.questionItems[index]
                                                        .fourthQuestion ==
                                                    value.questionItems[index]
                                                        .correctAnswer
                                                ? Colors.green.shade500
                                                : Colors.white,
                                            textColor: value
                                                        .questionItems[index]
                                                        .fourthQuestion ==
                                                    value.questionItems[index]
                                                        .correctAnswer
                                                ? Colors.white
                                                : Colors.black,
                                            title: value.questionItems[index]
                                                .fourthQuestion),
                                      ],
                                    ),
                                  ));
                            },
                          );
                        } else {
                          return const Center(
                              child: Text(''),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _confirmLogoutDialog(int index) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete question'),
          content: const Text('Are you sure want to delete this question?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.teal),
                )),
          ],
        );
      },
    );
    if (result ?? false) {
      _deletedItem(index);
    }
  }

  void _deletedItem(int index) async {
    ProcessResponse processResponse = await Provider.of<QuestionProvider>(context, listen: false).delete(index);
  context.showSnackBar(message: processResponse.message,error: !processResponse.success);
  }
}
