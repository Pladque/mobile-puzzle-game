import 'package:flutter/material.dart';

@immutable
class SnackBarMessage {

  static void snowSnackBar(BuildContext context, String text, int durationMilliSec)
  {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(milliseconds: durationMilliSec),
          backgroundColor: Colors.white,
          content: SizedBox(
            height: 20,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
        )
    );
  }
}
