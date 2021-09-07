import 'package:flutter/material.dart';

class CustomPopUp extends StatelessWidget {
  final String text;
  final void Function() close;
  final Color backgroundColor;
  final bool enableFeedback;
  final String imageDir;

  const CustomPopUp(
    this.close, {
    Key? key,
    this.imageDir = '',
    this.text = '',
    this.backgroundColor = const Color.fromARGB(255, 31, 31, 31),
    this.enableFeedback = true,
  }) : super(key: key);

  Widget getPopUp() {
    return (text != '' || imageDir == '')
        ? Container(
            margin: const EdgeInsets.only(bottom: 50),
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 72,
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(100),
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 80),
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.color),
                image: AssetImage(
                  imageDir,
                ),
                fit: BoxFit.fill,
              ),
            ),
          );
  }

  Widget getCloseButton() {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 20),
      child: MaterialButton(
        onPressed: close,
        enableFeedback: enableFeedback,
        child: const Text(
          'close',
          style: TextStyle(
            fontSize: 42,
            color: Colors.black,
          ),
        ),
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget popUp = getPopUp();
    Widget closeButton = getCloseButton();
    return Container(
      color: backgroundColor,
      height: 400,
      width: 350,
      margin: const EdgeInsets.only(bottom: 150),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 5.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Stack(
          children: [
            popUp,
            closeButton,
          ],
        ),
      ),
    );
  }
}
