import 'package:flutter/material.dart';

class StarsCounter extends StatelessWidget {
  final int amount;
  final Color starColor;
  const StarsCounter(this.amount, this.starColor,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: starColor,
          size: 24.0,
        ),
        Text(
          amount.toString(),
          style: TextStyle(
            color: starColor,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
