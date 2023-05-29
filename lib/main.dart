import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/database/db_controller.dart';
import 'package:flutter_quiz_app/provider/question_provider.dart';
import 'package:flutter_quiz_app/screen/start_quiz_screen.dart';
import 'package:flutter_quiz_app/screen/error_screen.dart';
import 'package:flutter_quiz_app/screen/home_screen.dart';
import 'package:flutter_quiz_app/screen/launch_screen.dart';
import 'package:flutter_quiz_app/screen/add_question_screen.dart';
import 'package:flutter_quiz_app/screen/create_quiz_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuestionProvider>(
      create: (context) => QuestionProvider(),
      builder: (context, child) {
        return  MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              centerTitle: true,
              backgroundColor: Colors.teal,
              titleTextStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/launch_screen',
          routes: {
            '/launch_screen': (context) => const LunchScreen(),
            '/home_screen': (context) => const HomeScreen(),
            '/create_quiz_screen': (context) => const CreateQuizScreen(),
            '/add_question_screen': (context) => const AddQuestionScreen(),
            '/start_quiz_screen': (context) => const StartQuizScreen(),
            '/error_screen': (context) => const ErrorScreen(),
          },
        );
      },

    );
  }
}
