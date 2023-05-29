import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.label,
    required this.controller,
    super.key,
  });

  final String label;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.grey,fontSize: 14),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.teal)),
      ),
    );
  }
}
