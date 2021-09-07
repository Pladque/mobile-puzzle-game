import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'menu.dart';

@immutable
class LoadingScreen extends StatefulWidget {
  final Color backgroundColor;
  final void Function(state) _changeState;
  final void Function() initTask;

  const LoadingScreen(this.backgroundColor, this._changeState, this.initTask,
      {Key? key})
      : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState(
      backgroundColor, _changeState, initTask);
}

class _LoadingScreenState extends State<LoadingScreen> {
  Color backgroundColor;
  final void Function(state) _changeState;
  final void Function() initTask;

  _LoadingScreenState(this.backgroundColor, this._changeState, this.initTask)
  {
    //backgroundColor = widget.backgroundColor;
  }

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((_) {
      runInitTasks();
    });
  }

  @protected
  Future runInitTasks() async {
    await Future.delayed(const Duration(milliseconds: 200));
    initTask();
    await Future.delayed(const Duration(milliseconds: 300));
    _changeState(state.menu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: InkWell(
        child:  Stack(
          fit: StackFit.expand,
          children: <Widget>[
             Container(
              decoration: const BoxDecoration(color: Colors.black),
            ),
             Container(
              color: backgroundColor,
            ),
             Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                 Expanded(
                  flex: 3,
                      child:  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                       Padding(
                        padding: EdgeInsets.only(top: 30.0),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(
                        'loading',
                        style: TextStyle(color: Colors.white, fontSize: 42),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
