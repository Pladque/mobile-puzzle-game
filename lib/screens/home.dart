import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logicandmathpuzzles/resources/data.dart';
import 'package:logicandmathpuzzles/screens/about.dart';
import 'package:logicandmathpuzzles/widgets/stars_counter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/menu.dart';
import '../screens/levels.dart';
import '../screens/level.dart';
import '../screens/level_completed.dart';
import '../screens/loading_screen.dart';
import '../widgets/back_button.dart';

@immutable
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const backgroundColor = Color.fromARGB(255, 31, 31, 31);
  static const appBarColor = Color.fromARGB(255, 8, 8, 8);
  late Data data;

  Color _starColor = Colors.white;

  SharedPreferences? _preferences;
  double _slideAnimationDirection = -1;

  int _currentLevel = 1;
  var _currentState = state.loadingScreen;
  bool _goingBack = false;

  static const _statesAndPreviousStates = {
    state.menu: state.menu,
    state.levels: state.menu,
    state.level: state.levels,
    state.about: state.menu,
    state.levelCompleted: state.levels,
  };

  int _finishedLevels = 0; //aka stars amount

  volume currentVolume = volume.voice;

  late AudioPlayer _player;
  void _playLevelCompletedSound() async {
    await _player.setAsset('assets/sounds/levelDoneSound.mp3');
    _player.play();
  }

  // INITIALIZATION
  Future<void> initializePreference() async {
    _preferences = await SharedPreferences.getInstance();
  }

  void initSavedVariables() {
    _finishedLevels = _preferences?.getInt('finishedLevels') ?? 0;
    _currentLevel = _preferences?.getInt('currentLevel') ?? 1;
    markCompletedLevels();
  }

  @override
  void initState() {
    _slideAnimationDirection = -1;
    _player = AudioPlayer();
    data = Data();
    initializePreference().whenComplete(() {
      setState(() {
        initSavedVariables();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _changeState(state newState) {
    setState(() {
      _currentState = newState;
    });
  }

  // going back in states based on _statesAndPreviousStates
  void _goBack() {
    _goingBack = true;
    _changeState(_statesAndPreviousStates[_currentState] as state);
  }

  // reads from memory which levels are completed and saves into levelsInfo
  void markCompletedLevels() {
    for (int i = 0; i < data.levelsInfo.length; i++) {
      data.levelsInfo[i]['solved'] = _preferences?.getBool(i.toString()) ?? false;
    }
  }

  // sets level as finished and saves it
  void markLevelAsFinished(int lvlNumber) async {
    setState(() {
      _finishedLevels += data.levelsInfo[lvlNumber]['solved'] as bool ? 0 : 1;
      data.levelsInfo[lvlNumber]['solved'] = true;

      _changeState(state.levelCompleted);
    });
    _preferences?.setInt("finishedLevels", _finishedLevels);
    _preferences?.setBool(lvlNumber.toString(), true);
  }

  // return world number in which _currentLevel is
  int getCurrentWorldNumber() {
    int i = 0;
    for (i = data.wordsInfo.length - 1; i > 0; i--) {
      if (data.wordsInfo[i]['firstLevelNumber'] as int <= _currentLevel) {
        break;
      }
    }

    return i;
  }

  // sets current level(if possible) otherwise changing state to state.levels
  void setCurrentLevel(int newLevel) {
    int currWordNum = getCurrentWorldNumber();

    if (currWordNum + 1 >= data.wordsInfo.length) {
      if (newLevel >=
          (data.wordsInfo[currWordNum]['firstLevelNumber'] as int) +
              (data.wordsInfo[currWordNum]['amountOfLevels'] as int)) {
        _changeState(state.levels);
        return;
      }
    } else if (newLevel <
        (data.wordsInfo[currWordNum + 1]['firstLevelNumber'] as int) ||
        (_finishedLevels >=
            (data.wordsInfo[currWordNum + 1]['RequiredStarsAmount'] as int))) {
      setState(() {
        _changeState(state.level);
        _currentLevel = newLevel;
      });
      return;
    } else {
      _changeState(state.levels);
    }
  }

  // sets volume to next
  volume changeVolume() {
    currentVolume = volume.values[
    (volume.values.indexOf(currentVolume) + 1) % volume.values.length];
    return currentVolume;
  }

  // Updates BodyWidget based on current state
  Widget updateBodyWidget() {
    switch (_currentState) {
      case state.menu:
        _starColor = Colors.white;
        return Menu(
            backgroundColor, _changeState, changeVolume, currentVolume);
      case state.levels:
        {
          _starColor = Colors.white;
          int i = getCurrentWorldNumber();

          return Levels(
            data.wordsInfo,
            data.levelsInfo,
            backgroundColor,
            setCurrentLevel,
            _finishedLevels,
            currentWord: i,
            enableFeedback: currentVolume == volume.voice,
          );
        }
      case state.level:
        {
          if (data.levelsInfo[_currentLevel]['solved'] as bool) {
            _starColor = Colors.yellow;
          }
          _preferences?.setInt('currentLevel', _currentLevel);

          return Level(
              _currentLevel,
              data.levelsInfo[_currentLevel]['ans'] as int,
              markLevelAsFinished,
              _playLevelCompletedSound,
              soundEnabled: currentVolume == volume.voice,
              vibrationEnabled: (currentVolume == volume.voice ||
                  currentVolume == volume.vibration));
        }
      case state.about:
        {
          _starColor = Colors.white;
          return const About();
        }
      case state.levelCompleted:
        {
          _starColor = Colors.white;
          return LevelCompleted(
            setCurrentLevel,
            _currentLevel.round(),
            currentVolume == volume.voice,
          );
        }
      case state.loadingScreen:
        {
          return LoadingScreen(backgroundColor, _changeState, () => {});
        }
    }
  }

  Widget updateBackButton() {
    return _currentState != state.menu
        ? CustomBackButton(_goBack, currentVolume)
        : Container();
  }

  late Widget bodyWidget;
  late Widget backButton;

  @override
  Widget build(BuildContext context) {
    bodyWidget = updateBodyWidget();
    backButton = updateBackButton();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Stack(
            children: <Widget>[
              backButton,
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  'Logic&math puzzles',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),

            ],
          ),
        ),
        backgroundColor: appBarColor,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 5, left: 5),
            child: StarsCounter(_finishedLevels, _starColor),
          ),
          AnimatedSwitcher(
            child: bodyWidget,
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation) {
              _slideAnimationDirection *= -1;
              Animation<Offset> offsetAnimation;
              if (!_goingBack) {
                offsetAnimation = Tween<Offset>(
                    begin: Offset(_slideAnimationDirection, 0.0),
                    end: Offset.zero)
                    .animate(animation);
              } else {
                offsetAnimation = Tween<Offset>(
                    begin: const Offset(0.0, -1.0),
                    end: const Offset(0.0, 0.0))
                    .animate(animation);
              }
              if (_goingBack) _goingBack = false;

              return ClipRect(
                  child: SlideTransition(
                      child: child, position: offsetAnimation));
            },
          )
        ],
      ),
    );
  }
}
