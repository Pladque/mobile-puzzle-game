import 'dart:ui';
import 'package:logicandmathpuzzles/widgets/field_control_button.dart';
import 'package:logicandmathpuzzles/widgets/input_button.dart';
import 'package:logicandmathpuzzles/widgets/input_field.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter/material.dart';

class InputSystem extends StatefulWidget {
  final String answer;
  final bool Function(String) validateAnswer;
  final bool vibrationEnabled;
  final bool enableFeedback;

  const InputSystem(this.answer, this.validateAnswer, this.vibrationEnabled,
      this.enableFeedback,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InputSystemState(
        answer, validateAnswer, vibrationEnabled, enableFeedback);
  }
}

class _InputSystemState extends State<InputSystem> {
  //const InputSystem({Key? key}) : super(key: key);
  String _value = '';
  final String answer;
  final bool Function(String) validateAnswer;
  final bool vibrationEnabled;
  final bool enableFeedback;

  _InputSystemState(this.answer, this.validateAnswer, this.vibrationEnabled,
      this.enableFeedback);

  bool canVibrate = true;

  void _changeValue(String newValue) {
    if (vibrationEnabled) Vibration.vibrate(duration: 10);
    setState(() {
      _value += newValue;
    });
  }

  void resetInput() {
    if (vibrationEnabled) Vibration.vibrate(duration: 15);
    setState(() {
      _value = '';
    });
  }

  void _deleteOne() {
    if (vibrationEnabled) Vibration.vibrate(duration: 10);
    setState(() {
      _value = _value.substring(0, _value.length - 1);
    });
  }

  Widget getInputField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InputFieldControlButton(
          () => validateAnswer(_value),
          'OK',
          () => {},
          enableFeedback: enableFeedback,
          widthDivider: 6,
        ),
        CustomInputField(_value.toString()),
        InputFieldControlButton(
          _deleteOne,
          'delete',
          resetInput,
          enableFeedback: enableFeedback,
          widthDivider: 5,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget inputField = getInputField();

    var keyboard = <Widget>[];
    for (int i = 0; i < 10; i++) {
      keyboard.add(InputButton(
        _changeValue,
        i.toString(),
        enableFeedback: enableFeedback,
      ));
    }

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          inputField,
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 2,
            children: [
              ...keyboard,
            ],
          )
        ],
      ),
    );
  }
}
