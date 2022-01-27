import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_of_life/models/game.dart';
import 'package:game_of_life/widgets/case.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<bool>> _array;
  Timer _timer;
  bool _running = false;
  String _title = "Game of life";
  double _valueTimer = 100;
  int _nbrCaseRow;
  int _nbrCaseCol;
  Size _screenSize;

  void _next() {
    setState(() {
      var temp = _array;
      _array = Game.initArray(_nbrCaseRow, _nbrCaseCol);
      _array = Game.update(temp);
    });
  }

  void _updateTimer() {
    _timer = Timer.periodic(Duration(milliseconds: _valueTimer.round()), (t) {
      _next();
    });
  }

  void _pauseTimer() {
    _timer.cancel();
  }

  void _onChangeSlider(double val) {
    setState(() {
      _valueTimer = val;
    });
    if (_running) {
      _pauseTimer();
      _updateTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_array == null) {
      _screenSize = MediaQuery.of(context).size;
      _nbrCaseCol =
          ((_screenSize.width - (_screenSize.width * 0.14)) / 30).floor();
      _nbrCaseRow =
          ((_screenSize.height - (_screenSize.height * 0.25)) / 30).floor();
      _array = Game.initArray(_nbrCaseRow, _nbrCaseCol);
    } else if (_screenSize != MediaQuery.of(context).size) {
      setState(() {
        _screenSize = MediaQuery.of(context).size;
        _nbrCaseCol =
            ((_screenSize.width - (_screenSize.width * 0.14)) / 30).floor();
        _nbrCaseRow =
            ((_screenSize.height - (_screenSize.height * 0.25)) / 30).floor();
        _array = Game.initArray(_nbrCaseRow, _nbrCaseCol);
      });
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          _title,
        ),
        actions: [
          SizedBox(
            width: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Change timer', style: TextStyle(fontSize: 20)),
              Text(
                '',
                textAlign: TextAlign.center,
              ),
              Slider(
                min: 100,
                max: 2100,
                divisions: 10,
                value: _valueTimer,
                onChanged: _onChangeSlider,
                label: 'timer: ' + _valueTimer.round().toString(),
              ),
            ],
          ),
          SizedBox(
            width: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.restore,
                ),
                tooltip: 'Restart game',
                onPressed: () {
                  setState(() {
                    _array = Game.initArray(_nbrCaseRow, _nbrCaseCol);
                  });
                },
              ),
              IconButton(
                  icon: Icon(
                    Icons.skip_next_rounded,
                  ),
                  tooltip: 'next step',
                  onPressed: _next),
            ],
          )
        ],
      ),
      body: ListView.builder(
              itemCount: _array.length,
              itemBuilder: (BuildContext context, int id) {
                List<Widget> col =
                    List<Widget>.generate(_nbrCaseCol.round(), (i) {
                  return Case(
                      onPress: _running
                          ? null
                          : () {
                              setState(() {
                                _array[id][i] = !_array[id][i];
                              });
                            },
                      isAlive: _array[id][i]);
                });

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: col,
                );
              }),
      floatingActionButton: FloatingActionButton(
        child: Icon(_running ? Icons.pause_rounded : Icons.play_arrow_rounded),
        onPressed: () {
          if (_running) {
            _pauseTimer();
          } else {
            _updateTimer();
          }

          setState(() {
            _running = !_running;
          });
        },
      ),
    );
  }
}
