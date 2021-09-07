import 'package:flutter/material.dart';
import 'nav_button.dart';
import '../screens/menu.dart';


class CustomBackButton extends StatelessWidget {
  final Function() goBack;
  final volume _currentVolume;
  const CustomBackButton(this.goBack,this._currentVolume, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: NavButton(
        const Color.fromARGB(0, 0, 0, 0),
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
