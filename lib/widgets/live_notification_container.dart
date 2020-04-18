import 'dart:async';

import 'package:flutter/material.dart';

class LiveNotificationContainer extends StatefulWidget {
  @override
  _LiveNotificationContainerState createState() =>
      _LiveNotificationContainerState();
}

class _LiveNotificationContainerState extends State<LiveNotificationContainer>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _colorTween;
  Timer _colorTimer;

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _colorTween = ColorTween(begin: Colors.red, end: Colors.transparent)
        .animate(_animationController);
    _colorTween.addListener(() {
      setState(() {});
    });
    _animationController.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _colorTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_animationController.status == AnimationStatus.completed) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _colorTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      decoration: BoxDecoration(
          color: _colorTween.value,
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
    );
  }
}
