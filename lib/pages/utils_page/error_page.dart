import 'package:feed_me/utils/styles.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hi i'm sorry..",
            style: feedMeTextTheme.displaySmall,
          ),
          Center(
            child: Text(
              'Something Went Wrong!',
              style: feedMeTextTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
