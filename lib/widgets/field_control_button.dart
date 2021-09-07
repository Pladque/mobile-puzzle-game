import 'package:flutter/material.dart';

class InputFieldControlButton extends StatelessWidget {
  final Function() onPressed;
  final Function() onLongPressed;
  final bool enableFeedback;
  final String contentText;
  final double widthDivider;

  const InputFieldControlButton(
      this.onPressed, this.contentText, this.onLongPressed,
      {this.widthDivider = 6, this.enableFeedback = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / this.widthDivider,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          contentText,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        onLongPress: onLongPressed,
        color: const Color.fromARGB(255, 15, 15, 15),
        enableFeedback: enableFeedback,
      ),
    );
  }
}
