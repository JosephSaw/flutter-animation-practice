import 'package:flutter/material.dart';

void main() => runApp(LogoApp());

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  Animation<double> sizeAnimation;
  Animation<double> opacityAnimation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    sizeAnimation = Tween<double>(begin: 0, end: 300).animate(controller);
    opacityAnimation = Tween<double>(begin: 0.1, end: 1).animate(controller);

    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addStatusListener((AnimationStatus status) {
        print('$status');
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(
        animation: animation,
      );
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

      static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
      static final _sizeTween = Tween<double>(begin: 0, end: 300);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    return Center(
      child: Container(
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}
