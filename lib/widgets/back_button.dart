import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import 'nav_button.dart';
import '../screens/menu.dart';

class CustomBackButton extends StatelessWidget {
  final Function() goBack;
  final volume _currentVolume;

  const CustomBackButton(this.goBack, this._currentVolume, {Key? key})
      : super(key: key);

  void _onPressedAction() {
    if (_currentVolume == volume.vibration || _currentVolume == volume.voice) {
      Vibration.vibrate(duration: 10);
    }

    goBack();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: NavButton(
        const Color.fromARGB(0, 255, 255, 255),
        goBack,
        heightDivider: 12,
        widthDivider: 5,
        fontSize: 32,
        marginAll: 0,
        enableBorder: false,
        enableFeedback: _currentVolume == volume.voice,
        //setting this to force showing icon instead of txt
        icon: const Icon(
          Icons.arrow_back_sharp,
          //color: _starColor,
          size: 32.0,
        ),
      ),
    );
  }
}
