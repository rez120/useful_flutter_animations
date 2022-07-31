import 'package:flutter/material.dart';

class FavoriteAnimationWithCurve extends StatefulWidget {
  const FavoriteAnimationWithCurve({Key? key}) : super(key: key);

  @override
  State<FavoriteAnimationWithCurve> createState() =>
      _FavoriteAnimationWithCurveState();
}

class _FavoriteAnimationWithCurveState extends State<FavoriteAnimationWithCurve>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation _colorAnimation;

  late Animation _sizeAnimation;

  late Animation _curve;

  bool isFav = false;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    Animation<double> curve =
        CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);
    _colorAnimation =
        ColorTween(begin: Colors.grey, end: Colors.red).animate(curve);
    // spits values between zero to one

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 80, end: 110), weight: 55),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 110, end: 80), weight: 45),
    ]).animate(curve);

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
