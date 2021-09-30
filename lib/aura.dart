library aura;

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Aura extends StatefulWidget{
  final Duration? animationPeriod;
  final double minHeight;
  final double maxHeight;
  final List<Color>? colors;
  final Alignment begin;
  final Alignment end;
  final double lowerBound;
  final double upperBound;

  Aura({this.animationPeriod, this.minHeight=10, this.maxHeight=20, this.colors, this.begin=Alignment.bottomCenter, this.end=Alignment.topCenter, this.lowerBound=0, this.upperBound=1}):assert(lowerBound<1&&lowerBound>=0&&upperBound>0&&upperBound<=1&&lowerBound<upperBound);
  @override
  State<StatefulWidget> createState() => _AuraState();

}

class _AuraState extends State<Aura> with SingleTickerProviderStateMixin{
  late final AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(vsync: this, lowerBound: widget.lowerBound, upperBound: widget.upperBound);
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
  final double maxHeight;

  const AuraAnimation({required AnimationController controller, this.colors, required this.begin, required this.end, this.maxHeight=100})
      : super(listenable: controller);

  AnimationController get animator => listenable as AnimationController;

  @override
  Widget build(BuildContext context) {
    print(animator.value);
    int alpha = (animator.value*255).toInt();
    return Container(
          alignment: begin,
          height: maxHeight,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin,
                  end: end,
                  colors: colors ?? [
                    Color((alpha<<24)|(0x00FFFFFF&Colors.pink.value)),
                    Color(0x00FFFFFF)
                  ]
              )
          ),
        );
  }
}
