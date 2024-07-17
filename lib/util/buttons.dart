import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final VoidCallback onPressed; // Added onPressed parameter

  Button({
    Key? key,
    required this.text,
    required this.height,
    required this.width,
    required this.onPressed, // Added onPressed parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Handling button press
      child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 36, 56, 114),
          borderRadius: BorderRadius.vertical(),
        ),
        child: Center(
          child: Text(
            text,
            style:  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.sp),
          ),
        ),
      ),
    );
  }
}
