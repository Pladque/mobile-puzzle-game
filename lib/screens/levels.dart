import 'package:flutter/material.dart';
import '../widgets/nav_button.dart';
import '../widgets/levels_arrow_button.dart';
import '../resources/snack_bar_message.dart';

@immutable
class Levels extends StatefulWidget {
  final int completedLevelsAmount;
  final Color backgroundColor;
  final void Function(int) _loadLevel;
  final List wordsInfo;
  final List levelsInfo;
  final double currentLevel = 1.0;

  final bool enableFeedback;

  final int currentWord;

  const Levels(this.wordsInfo, this.levelsInfo, this.backgroundColor,
      this._loadLevel, this.completedLevelsAmount,
      {this.currentWord = 0, this.enableFeedback = true, Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LevelsState(wordsInfo, levelsInfo, backgroundColor, _loadLevel,
        completedLevelsAmount,
        currentWord: currentWord, enableFeedback: enableFeedback);
  }
}

class _LevelsState extends State<Levels> {
  int _amountOfLevels = 0;
  int _firstLevelNumberInWorld = 0;
  int completedLevelsAmount;
  final Color backgroundColor;
  final void Function(int) _loadLevel;
  final List wordsInfo;
  double currentLevel = 1.0;
  final List levelsInfo;
  int currentWord = 0;
  final bool enableFeedback;

  _LevelsState(this.wordsInfo, this.levelsInfo, this.backgroundColor,
      this._loadLevel, this.completedLevelsAmount,
      {this.currentWord = 0, this.enableFeedback = true}) {
    _amountOfLevels = wordsInfo[currentWord]['amountOfLevels'];
    _firstLevelNumberInWorld = wordsInfo[currentWord]['firstLevelNumber'];


  }

  void nextLevels() {
    if (completedLevelsAmount <
        wordsInfo[currentWord + 1]['RequiredStarsAmount']) {
      SnackBarMessage.snowSnackBar(
          context,
          'You have to collect ${wordsInfo[currentWord + 1]['RequiredStarsAmount']} '
          'stars!',
          2000);
    } else {
      setState(() {
        currentWord++;
        _amountOfLevels = wordsInfo[currentWord]['amountOfLevels'];
        _firstLevelNumberInWorld = wordsInfo[currentWord]['firstLevelNumber'];
      });
    }
  }

  void previousLevels() {
    setState(() {
      currentWord--;
      _amountOfLevels = wordsInfo[currentWord]['amountOfLevels'];
      _firstLevelNumberInWorld = wordsInfo[currentWord]['firstLevelNumber'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var levels = <Widget>[];
    for (int i = _firstLevelNumberInWorld;
        i < _amountOfLevels + _firstLevelNumberInWorld;
        i++) {
      levels.add(
        NavButton(
          backgroundColor,
          () => {_loadLevel(i)},
          text: levelsInfo[i.round()]['levelNumber'].toString(),
          fontSize: MediaQuery.of(context).size.width / 15,
          heightDivider: 12,
          widthDivider: 4,
          levelNumber: i,
          marginAll: 0,
          enableFeedback: enableFeedback,
          onlyText: !(levelsInfo[i.round()]['solved'] as bool),
          onlyIcon: (levelsInfo[i.round()]['solved'] as bool),
        ),
      );
    }

    var world = Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 50, right: 50, bottom: 100, top: 30),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Wrap(
          children: [
            ...levels,
          ],
        ),
      ),
    );

    var worldNum = Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 50, top: 20),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          currentWord.toString(),
          style: TextStyle(
            fontSize: 52,
            color: wordsInfo[currentWord]['colorTheme'] as Color,
          ),
        ),
      ),
    );

    var leftArrowButton = LevelsArrowButton(
      currentWord > 0,
      backgroundColor,
      previousLevels,
      enableFeedback,
      const Icon(Icons.arrow_left, size: 32.0),
    );

    var rightArrowButton = LevelsArrowButton(
      currentWord < wordsInfo.length - 1,
      backgroundColor,
      nextLevels,
      enableFeedback,
      const Icon(Icons.arrow_right, size: 32.0),
    );

    return Align(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        height: double.infinity,
        margin: const EdgeInsets.only(top: 5, bottom: 30),
        child: Stack(
          children: [
            worldNum,
            world,
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  leftArrowButton,
                  rightArrowButton,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
