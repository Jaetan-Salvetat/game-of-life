import 'package:flutter/material.dart';

class Case extends StatelessWidget {
  final Function _onPress;
  final bool _isAlive;

  const Case({onPress, isAlive})
      : _onPress = onPress,
        _isAlive = isAlive;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPress,
      child: Container(
        width: 30,
        height: 30,
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: _isAlive ? Colors.black : Colors.white38,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: Colors.black38
            )
        ),
      ),
    );
  }
}
