import 'package:flutter/material.dart';
import 'nav_button.dart';

class LevelsArrowButton extends StatelessWidget {
  final bool show;
  final Color backgroundColor;
  final Function() previousLevels;
  final bool enableFeedback;
  final Icon icon;

  const LevelsArrowButton(this.show, this.backgroundColor, this.previousLevels,
      this.enableFeedback, this.icon,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return show
        ? NavButton(
            backgroundColor,
            previousLevels,
            fontSize: 22,
            heightDivider: 12,
            widthDivider: 4,
            marginAll: 0,
            onlyIcon: true,
            enableFeedback: enableFeedback,
            icon: icon,
          )
        : NavButton(
            backgroundColor,
            () => {},
            fontSize: 22,
            heightDivider: 12,
            widthDivider: 4,
            marginAll: 0,
            onlyText: true,
            enableBorder: false,
            enableFeedback: enableFeedback,
          );
  }
}
