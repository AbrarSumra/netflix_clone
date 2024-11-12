import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  const NormalText({
    super.key,
    required this.title,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.normal,
    this.textOverflow,
    this.maxLines = 1,
    this.color = Colors.black,
    this.textAlign = TextAlign.start,
    this.textDecoration = TextDecoration.none,
  });

  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final TextOverflow? textOverflow;
  final int maxLines;
  final Color color;
  final TextAlign textAlign;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      overflow: textOverflow,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        decoration: textDecoration,
      ),
    );
  }
}
