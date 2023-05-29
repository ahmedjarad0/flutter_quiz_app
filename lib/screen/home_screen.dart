import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz App',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
      ),
      drawer: Drawer(
          child: Column(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            accountName: Text('Ahmed Jarad'),
            accountEmail: Text('ahmed@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: Text(
                'A',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.create),
            title: const Text('Create Quiz'),
            onTap: () {
              Future.delayed(const Duration(microseconds: 500),(){
                Navigator.pushNamed(context, '/create_quiz_screen');

              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.quiz),
            title: const Text('Start Quiz'),
            onTap: () {
              Navigator.pushNamed(context, '/start_quiz_screen');
            },
          ),
          const Divider(
            thickness: 1,
          ),
           ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ],
      )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/quiz.png'),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/start_quiz_screen');
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: Colors.teal),
            child: const Text('Let\'s Start! '),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
