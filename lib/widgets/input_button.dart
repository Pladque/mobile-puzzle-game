import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  final Function(String) changeInputSystemValue;
  final bool enableFeedback;
  final String contentText;
  final double widthDivider;

  const InputButton(this.changeInputSystemValue, this.contentText,
      {this.widthDivider = 6, this.enableFeedback = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / widthDivider,
      child: MaterialButton(
        onPressed: () => changeInputSystemValue(contentText),
        enableFeedback: enableFeedback,
        child: Text(
          contentText,
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width / 18,
          ),
        ),
        color: const Color.fromARGB(0, 255, 255, 255),
        textColor: Colors.white,
      ),
    );
  }
}
