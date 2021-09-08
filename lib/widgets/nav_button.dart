import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

@immutable
class NavButton extends StatelessWidget {
  final VoidCallback selectHandler;
  final Color backgroundColor;

  final int levelNumber;

  final double heightDivider;
  final double widthDivider;
  final double iconAndTextContainerWidthDivider;

  final double marginAll;
  final bool enableBorder;

  final String text;
  final bool onlyText;
  final double fontSize;
  final double fontSizeDivider;

  final Color borderColor;

  final Icon icon;
  final bool onlyIcon;
  static const double iconSize = 24.0;

  final bool enableFeedback;

  const NavButton(
    this.backgroundColor,
    this.selectHandler, {
    this.enableBorder = true,
    this.text = '',
    this.levelNumber = -1,
    this.heightDivider = 80,
    this.widthDivider = 400,
    this.fontSize = 48,
    this.marginAll = 20,
    this.icon = const Icon(Icons.star, size: NavButton.iconSize),
    this.onlyIcon = false,
    this.onlyText = false,
    this.fontSizeDivider = 10,
    this.iconAndTextContainerWidthDivider = -1,
    this.enableFeedback = true,
    this.borderColor = Colors.white,
        Key? key,
  }): super(key: key);

  Widget getContent(BuildContext context)
  {
    if( iconAndTextContainerWidthDivider == -1)
      {
        return Container(
          margin: EdgeInsets.all(marginAll),
          child: onlyText
              ? Text(
            text,
            style: TextStyle(
              fontSize:
              MediaQuery.of(context).size.width / fontSizeDivider,
            ),
          )
              : onlyIcon
              ? icon
              : Wrap(
            children: [
              Container(
                  child: icon, margin: const EdgeInsets.only(right: 5)),
              Text(
                text,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width /
                      fontSizeDivider,
                ),
              ),
            ],
          ),
        );
      }
    else {
      return  Container(
        margin: EdgeInsets.all(marginAll),
        width: double.infinity,
        child: onlyText
            ? Text(
          text,
          style: TextStyle(
            fontSize:
            MediaQuery.of(context).size.width / fontSizeDivider,
          ),
        )
            : onlyIcon
            ? icon
            : Wrap(
          children: [
            Container(
              //color: Colors.red,
                child: icon,
                margin: const EdgeInsets.only(right: 5)),
            Container(
              //color: Colors.green,
              width: 130,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 5),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width /
                      fontSizeDivider,
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  void _onPressedAction()
  {
    if (enableFeedback) Vibration.vibrate(duration: 10);
    selectHandler();
  }

  @override
  Widget build(BuildContext context) {
    Widget _iconAndTextContainer = getContent(context);

    return Container(
      width: MediaQuery.of(context).size.width / widthDivider,
      margin: const EdgeInsets.all(5),
      child: MaterialButton(
        height: MediaQuery.of(context).size.height / heightDivider,
        minWidth: MediaQuery.of(context).size.width / widthDivider,
        color: backgroundColor,
        textColor: Colors.white,
        enableFeedback: enableFeedback,
        shape: enableBorder
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: borderColor, width: 2),
              )
            : null,
        child: _iconAndTextContainer,
        onPressed: _onPressedAction,
        splashColor: Colors.white,
      ),
    );
  }
}
