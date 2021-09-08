import 'package:flutter/material.dart';
import '../widgets/nav_button.dart';

enum state {
  menu,
  levels,
  level,
  about,
  levelCompleted,
  loadingScreen,
}

enum volume {
  voice,
  vibration,
  silence,
}

class Menu extends StatefulWidget {
  final Color backgroundColor;
  final void Function(state) changeState;
  final volume Function() changeVolume;
  final volume _currentVolume;

  const Menu(this.backgroundColor, this.changeState, this.changeVolume,
      this._currentVolume,
      {Key? key})
      : super(key: key);

  @override
  _MenuState createState() =>_MenuState();

}

class _MenuState extends State<Menu> {
  Color backgroundColor = Colors.black;
  void Function(state)? changeState;
  volume Function()? changeVolume;
  static const double fontSizeDivider = 12;
  static const double buttonMarginAll = 15;
  static const double buttonWidthDivider = 1.25;
  final double iconAndTextContainerWidthDivider = 0.5;

  volume _currentVolume = volume.voice;
  Icon _volumeIcon = const Icon(Icons.volume_up, size: 52);
  String _volumeText = 'all';

  @override
  void initState() {
    backgroundColor = widget.backgroundColor;
    changeState = widget.changeState;
    changeVolume = widget.changeVolume;
    _currentVolume = widget._currentVolume;

    _setVolumeIconAndText();

    super.initState();
  }

  void _setVolumeIconAndText() {
    switch (_currentVolume) {
      case volume.voice:
        {
          _volumeIcon = const Icon(Icons.volume_up, size: 52);
          _volumeText = 'all';
          break;
        }
      case volume.vibration:
        {
          _volumeIcon = const Icon(Icons.vibration, size: 52);
          _volumeText = 'vibration';
          break;
        }
      case volume.silence:
        {
          _volumeIcon =
              const Icon(Icons.do_not_disturb_on_total_silence, size: 52);
          _volumeText = 'silence';
          break;
        }
    }
  }

  void _volumeChangeHandler() {
    setState(() {
      _currentVolume = changeVolume!();
      _setVolumeIconAndText();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: const EdgeInsets.only(bottom: 20, top: 30),
      //color: Colors.red;,
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 120),
            height: MediaQuery.of(context).size.height / 5,
            alignment: Alignment.topCenter,
            child: Text(
              'Logic&math \n puzzles',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 10,
                color: Colors.white,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              NavButton(
                backgroundColor,
                () => {changeState!(state.level)},
                text: 'play',
                widthDivider: buttonWidthDivider,
                icon: const Icon(Icons.play_arrow, size: 52),
                fontSizeDivider: fontSizeDivider,
                marginAll: buttonMarginAll,
                enableFeedback: _currentVolume == volume.voice,
                iconAndTextContainerWidthDivider:
                    iconAndTextContainerWidthDivider,
              ),
              NavButton(
                backgroundColor,
                () => {changeState!(state.levels)},
                text: 'levels',
                widthDivider: buttonWidthDivider,
                icon: const Icon(Icons.menu, size: 50),
                fontSizeDivider: fontSizeDivider,
                marginAll: buttonMarginAll,
                enableFeedback: _currentVolume == volume.voice,
                iconAndTextContainerWidthDivider:
                    iconAndTextContainerWidthDivider,
              ),
              NavButton(
                backgroundColor,
                () => {changeState!(state.about)},
                text: 'about',
                widthDivider: buttonWidthDivider,
                icon: const Icon(Icons.description, size: 52),
                fontSizeDivider: fontSizeDivider,
                enableFeedback: _currentVolume == volume.voice,
                marginAll: buttonMarginAll,
                iconAndTextContainerWidthDivider:
                    iconAndTextContainerWidthDivider,
              ),
              NavButton(
                backgroundColor,
                _volumeChangeHandler,
                text: _volumeText,
                widthDivider: buttonWidthDivider,
                fontSizeDivider: fontSizeDivider,
                enableFeedback: _currentVolume == volume.voice,
                icon: _volumeIcon,
                marginAll: buttonMarginAll,
                iconAndTextContainerWidthDivider:
                    iconAndTextContainerWidthDivider,
              ),
              Container(
                height: 30,
              )
            ],
          ),
        ],
      ),
    );
  }
}
