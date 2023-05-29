import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/database/sql_helper.dart';
import 'package:flutter_quiz_app/screen/error_screen.dart';
import 'package:flutter_quiz_app/widgets/check_answer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/question_provider.dart';

class StartQuizScreen extends StatefulWidget {
  const StartQuizScreen({Key? key}) : super(key: key);

  @override
  State<StartQuizScreen> createState() => _StartQuizScreenState();
}

class _StartQuizScreenState extends State<StartQuizScreen> {
  int _currentPage = 0;
  int score = 0;
  bool openScore = false;
  bool loading = false;
  List<Map<String, dynamic>> listQs = [];

  void getItems() async {
    loading = true;
    final listQuestion  = await SQLHelper.getItems();
    log(listQs.length.toString());
    setState(() {
      listQs = listQuestion;
      loading = false;
    });
  }

  done(int index, String answer) {
    if (listQs[index][answer] == listQs[index]["answerCorrect"]) {
      score++;
    }
    if (_currentPage < listQs.length - 1) {
      _currentPage++;
    } else {
      log(score.toString());
      openScore = true;
    }
    log(_currentPage.toString());
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItems();
    Provider.of<QuestionProvider>(context, listen: false).read();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          openScore
              ?
          //here score

          score < listQs.length / 2 ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Oops!',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.teal),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'images/fail.png',
                height: 200,
                width: double.infinity,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                ' Your Score : ${score.toString()}/${listQs.length}',
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5,),
              const Text(
                'Sorry, better luck next time !',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 25,),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home_screen');
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    minimumSize: const Size(200, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.teal),
                child: const Text('Back to home',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),

            ],
          ) : Column(children: [
            Text(
              'congratulations!',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.teal),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'images/result.jpg',
              height: 200,
              width: double.infinity,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              ' Your Score : ${score.toString()}/${listQs.length}',
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5,),
            const Text(
              'You\'re a superstar!',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 25,),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home_screen');
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  minimumSize: const Size(200, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.teal),
              child: const Text('Back to home',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],)
              :


          //here Qs
          Expanded(
            child: Consumer<QuestionProvider>(
                builder: (context, value, child) {
                  if (listQs.length >= 5) {
                    return PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),

                      itemCount: listQs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Question ${_currentPage + 1}',
                                    style: GoogleFonts.cairo(
                                        fontSize: 20,
                                        color: Colors.teal,
                                        height: 0.8,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' /${listQs.length}',
                                    style: GoogleFonts.cairo(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              CheckAnswer(
                                textColor: Colors.white,
                                title: listQs[_currentPage]
                                ['questions'],
                                color: Colors.teal,
                              ),
                              const SizedBox(height: 10),
                              CheckAnswer(
                                onTap: () {
                                  log('message');
                                  done(_currentPage, 'answerOne');
                                },
                                title: listQs[_currentPage]
                                ['answerOne'],
                                colorBorder: Colors.teal,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CheckAnswer(
                                  onTap: () {
                                    done(_currentPage, 'answerTwo');
                                  },
                                  title: listQs[_currentPage]
                                  ['answerTwo'],
                                  colorBorder: Colors.teal),
                              const SizedBox(
                                height: 10,
                              ),
                              CheckAnswer(
                                  onTap: () {
                                    done(_currentPage, 'answerThree');
                                  },
                                  title: listQs[_currentPage]
                                  ['answerThree'],
                                  colorBorder: Colors.teal),
                              const SizedBox(
                                height: 10,
                              ),
                              CheckAnswer(
                                  onTap: () {
                                    done(_currentPage, 'answerFour');
                                  },
                                  title: listQs[_currentPage]
                                  ['answerFour'],
                                  colorBorder: Colors.teal),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const ErrorScreen();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
