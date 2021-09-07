import 'package:flutter/material.dart';

@immutable
class LevelCompleted extends StatelessWidget {
  final void Function(int) loadLevelSafe;
  final int finishedLevel;
  final bool enableFeedback;

  const LevelCompleted(
      this.loadLevelSafe, this.finishedLevel, this.enableFeedback,
      {Key? key})
      : super(key: key);

  void nextLevel() {
    loadLevelSafe(finishedLevel + 1);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
          child: RawMaterialButton(
        enableFeedback: enableFeedback,
        onPressed: nextLevel,
        elevation: 2.0,
        fillColor: Colors.white,
        child: const Icon(
          Icons.navigate_next,
          size: 150.0,
        ),
        padding: const EdgeInsets.all(15.0),
        shape: const CircleBorder(),
      )),
    );
  }
}
