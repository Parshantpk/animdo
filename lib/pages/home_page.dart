import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double _buttonRadius = 100;
  final Tween<double> _backgroundScale = Tween<double>(begin: 0.0, end: 1.0);
  AnimationController? _starAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _starAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 4,
      ),
    );
    _starAnimationController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _pageBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _circularAnimationButton(),
              _starIcon(),
            ],
          ),
        ],
      ),
    ));
  }

  Widget _pageBackground() {
    return TweenAnimationBuilder(
      tween: _backgroundScale,
      curve: Curves.easeInOutCubicEmphasized,
      duration: const Duration(seconds: 2),
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: Container(
        color: Colors.teal,
      ),
    );
  }

  Widget _circularAnimationButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _buttonRadius += _buttonRadius == 200 ? -100 : 100;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.bounceInOut,
          height: _buttonRadius,
          width: _buttonRadius,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(_buttonRadius),
          ),
          child: const Center(
            child: Text(
              'Basic!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _starIcon() {
    return AnimatedBuilder(
      animation: _starAnimationController!.view,
      builder: (buildContext, child) {
        return Transform.rotate(
          angle: _starAnimationController!.value * 2 * pi,
          child: child,
        );
      },
      child: const Icon(
        Icons.star,
        size: 100,
        color: Colors.white,
      ),
    );
  }
}
