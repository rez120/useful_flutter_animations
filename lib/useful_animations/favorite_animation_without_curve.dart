import 'package:flutter/material.dart';

class FavoriteAnimationWithoutCurve extends StatefulWidget {
  const FavoriteAnimationWithoutCurve({Key? key}) : super(key: key);

  @override
  State<FavoriteAnimationWithoutCurve> createState() =>
      _FavoriteAnimationWithoutCurveState();
}

class _FavoriteAnimationWithoutCurveState
    extends State<FavoriteAnimationWithoutCurve>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation _colorAnimation;

  late Animation _sizeAnimation;

  bool isFav = false;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _colorAnimation =
        ColorTween(begin: Colors.grey, end: Colors.red).animate(_controller);
    // spits values between zero to one

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 80, end: 110), weight: 55),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 110, end: 80), weight: 45),
    ]).animate(_controller);

    _controller.addListener(() {
      // print(_controller.value);
      // print(_colorAnimation.value);
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
      print(status);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: ((context, child) {
        return IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {
            setState(() {
              isFav ? _controller.reverse() : _controller.forward();
            });
          },
          color: _colorAnimation.value,
          iconSize: _sizeAnimation.value,
        );
      }),
    );
  }
}
