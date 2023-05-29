import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckAnswer extends StatelessWidget {
  const CheckAnswer({
    required this.title,
    this.color ,
    this.textColor = Colors.black ,
    this.onTap ,
    this.colorBorder,
    super.key,
  });

  final String title;
  final Color? color;
 final Function ()? onTap ;
 final Color ? colorBorder ;
 final Color ? textColor ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colorBorder??Colors.white),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500,color: textColor ),
            ),
          ],
        ),
      ),
    );
  }
}
