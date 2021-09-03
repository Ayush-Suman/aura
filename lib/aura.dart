library aura;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Aura extends StatefulWidget{
  final Duration? animationPeriod;
  final double minHeight;
  final double maxHeight;
  final List<Color>? colors;
  final Alignment begin;
  final Alignment end;

  Aura({this.animationPeriod, this.minHeight=10, this.maxHeight=20, this.colors, this.begin=Alignment.bottomCenter, this.end=Alignment.topCenter});
  @override
  State<StatefulWidget> createState() => _AuraState();

}

class _AuraState extends State<Aura> with SingleTickerProviderStateMixin{
  late final AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(vsync: this, lowerBound: widget.minHeight, upperBound: widget.maxHeight);
    animationController.repeat(reverse: true, period: widget.animationPeriod??kThemeAnimationDuration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuraAnimation(controller: animationController, colors: widget.colors, end: widget.end, begin: widget.begin);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class AuraAnimation extends AnimatedWidget {
  final List<Color>? colors;
  final Alignment begin;
  final Alignment end;

  const AuraAnimation({required AnimationController controller, this.colors, required this.begin, required this.end})
      : super(listenable: controller);

  AnimationController get animator => listenable as AnimationController;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
        height: animator.upperBound,
        child: Container(
          alignment: begin,
          height: animator.value,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin,
                  end: end,
                  colors: colors ?? [
                    Colors.pink,
                    Color(0x00FFFFFF)
                  ]
              )
          ),
        ));
  }
}
