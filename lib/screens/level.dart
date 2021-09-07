import 'package:flutter/material.dart';
import 'package:logicandmathpuzzles/resources/ad_state.dart';
import 'package:vibration/vibration.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:async';

import '../widgets/level_image.dart';
import '../widgets/input_system.dart';
import '../widgets/custom_popup.dart';
import '../resources/snack_bar_message.dart';

@immutable
class Level extends StatefulWidget {
  final int levelNumber;
  final int lvlNumberDouble;
  final int ans;
  final bool vibrationEnabled;
  final bool soundEnabled;

  final void Function(int) _markLevelAsSolved;
  final void Function() _playLevelDoneSound;

  const Level(this.levelNumber, this.lvlNumberDouble, this.ans,
      this._markLevelAsSolved, this._playLevelDoneSound,
      {this.vibrationEnabled = true, this.soundEnabled = true, Key? key})
      : super(key: key);

  // todo: do it that way https://stackoverflow.com/questions/46057353/controlling-state-from-outside-of-a-statefulwidget
  @override
  State<StatefulWidget> createState() {
    return _LevelState(
      lvlNumberDouble,
      levelNumber,
      ans,
      _markLevelAsSolved,
      _playLevelDoneSound,
      vibrationEnabled: vibrationEnabled,
      soundEnabled: soundEnabled,
    );
  }
}

class _LevelState extends State<Level> {
  bool isLoading = false;

  final int levelNumber;
  final int lvlNumberDouble;
  final int ans;
  String hintImgDir = '0';
  String puzzleImgDir = '0';
  final bool vibrationEnabled;
  final bool soundEnabled;

  final void Function(int) _markLevelAsSolved;
  final void Function() _playLevelDoneSound;

  bool adLoadFailed = false;
  late RewardedAd _rewardedAd;
  bool showingHint = false;
  bool showingSolution = false;
  bool showedHint = false;
  bool showedSolution = false;

  late Timer _timer;
  int _timeToAd = 10;

  _LevelState(this.levelNumber, this.lvlNumberDouble, this.ans,
      this._markLevelAsSolved, this._playLevelDoneSound,
      {this.vibrationEnabled = true, this.soundEnabled = true}) {
    puzzleImgDir = 'assets/levels/' + levelNumber.toString() + '.png';
    hintImgDir = 'assets/hints/' + levelNumber.toString() + '.png';
  }

  void startTimer() async {
    if (_timeToAd > 0) {
      const oneSec = Duration(seconds: 1);
      _timer = Timer.periodic(
        oneSec,
        (Timer timer) {
          if (_timeToAd == 0) {
            timer.cancel();
          } else {
            _timeToAd--;
          }
        },
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  bool _validateAnswer(String answer) {
    if (int.parse(answer) == ans) {
      if (soundEnabled) _playLevelDoneSound();
      _markLevelAsSolved(levelNumber);
      return true;
    } else {
      if (vibrationEnabled) {
        Vibration.vibrate(duration: 200);
      }

      SnackBarMessage.snowSnackBar(context, 'Wrong answer!', 500);

      return false;
    }
  }

  void closeHintOrSolution() {
    setState(() {
      showingHint = false;
      showingSolution = false;
    });
  }

  void showHint() async {
    if (adLoadFailed) {
      SnackBarMessage.snowSnackBar(context, 'Error while loading an ad', 900);
      await Future.delayed(const Duration(seconds: 1));
      SnackBarMessage.snowSnackBar(
          context, 'Make sure you have internet connection', 900);
      return;
    } else if (_timeToAd > 0) {
      SnackBarMessage.snowSnackBar(
          context, 'wait ${_timeToAd}sec until checking a hint', 700);
      return;
    }

    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) => {},
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        //SnackBarMessage.snowSnackBar(context, 'ad loading failed', 700);
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        SnackBarMessage.snowSnackBar(context, 'ad loading failed', 700);
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => {},
    );

    if (!showedHint) {
      _rewardedAd.show(
          onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {
        setState(() {
          showingHint = true;
          showedHint = true;
        });
      });
    } else {
      setState(() {
        showingHint = true;
      });
    }
  }

  void showSolution() async {
    if (!showedHint) {
      SnackBarMessage.snowSnackBar(context, 'show hint first!', 700);
    } else {
      if (!showedSolution) {
        _rewardedAd.show(
            onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) {
          setState(() {
            showingSolution = true;
            showedSolution = true;
          });
        });
      } else {
        setState(() {
          showingSolution = true;
        });
      }
    }
  }

  Widget getPopUp() {
    if (showingHint) {
      return CustomPopUp(
        closeHintOrSolution,
        imageDir: hintImgDir,
        enableFeedback: soundEnabled,
      );
    } else if (showingSolution) {
      return CustomPopUp(
        closeHintOrSolution,
        text: ans.toString(),
        enableFeedback: soundEnabled,
      );
    } else {
      return CustomPopUp(
        closeHintOrSolution,
        text: '',
        enableFeedback: soundEnabled,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    RewardedAd.load(
      adUnitId: AdHelper().bannerAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          adLoadFailed = true;
        },
      ),
    );

    Widget popUp = getPopUp();
    const Widget solutionTextWidget = Text(
      'solution',
      style: TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
    );

    const Widget hintTextWidget = Text(
      'hint',
      style: TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
    );

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LevelImage(puzzleImgDir, 2.2, 1.1),
            InputSystem(
              ans.toString(),
              _validateAnswer,
              vibrationEnabled,
              soundEnabled,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: showHint,
                  enableFeedback: soundEnabled,
                  child: hintTextWidget,
                  color: const Color.fromARGB(255, 15, 15, 15),
                ),
                const SizedBox(width: 20),
                MaterialButton(
                  onPressed: showSolution,
                  enableFeedback: soundEnabled,
                  child: solutionTextWidget,
                  color: const Color.fromARGB(255, 15, 15, 15),
                ),
              ],
            )
          ],
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          width: MediaQuery.of(context).size.width,
          top: !showingSolution && !showingHint
              ? MediaQuery.of(context).size.height
              : 15,
          //bottom:  0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: popUp,
          ),
        ),
      ],
    );
  }
}
