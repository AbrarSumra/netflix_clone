import 'package:flutter/material.dart';
import 'package:netflix_clone/app/screens/widget/text_widget/normal_text.dart';

class ButtonL extends StatelessWidget {
  const ButtonL({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.btnColor = Colors.black,
    this.iconColor = Colors.white,
    this.textColor = Colors.white,
    this.isLoading = false,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color btnColor;
  final Color iconColor;
  final Color textColor;
  final bool isLoading; // New parameter

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: isLoading ? null : onTap, // Disable tap if loading
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
            : FittedBox(
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 30,
                      color: iconColor,
                    ),
                    const SizedBox(width: 8),
                    NormalText(
                      title: title,
                      fontSize: 18,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
