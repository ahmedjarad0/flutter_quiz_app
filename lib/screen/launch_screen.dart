import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LunchScreen extends StatefulWidget {
  const LunchScreen({Key? key}) : super(key: key);

  @override
  State<LunchScreen> createState() => _LunchScreenState();
}

class _LunchScreenState extends State<LunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, '/home_screen');
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [
          Color(0xff1B9C85),
          Color(0xffA0D8B3),
        ])),
        child: Text('Quiz App',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
      ),
    );
  }
}
