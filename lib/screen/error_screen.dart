import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sorry!',
            style: GoogleFonts.almarai(
                fontWeight: FontWeight.bold, fontSize: 26, color: Colors.teal),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'You must add at least 5 questions to start !',
            style: GoogleFonts.almarai(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            'images/faq.png',
            width: double.infinity,
            height: 250,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home_screen');
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: Colors.teal),
            child: Text(
              'Back to home',
              style: GoogleFonts.almarai(fontSize: 18, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
