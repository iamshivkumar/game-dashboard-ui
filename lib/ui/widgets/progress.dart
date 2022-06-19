import 'dart:math';

import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  final Widget child;
  final double progress;
  ProgressWidget({required this.child, required this.progress});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final size = 220.0;
    final axisSize = size + 32;
    double angle = progress * 2 * pi;
    double radius = size / 2;
    double x = sin(angle) * (radius - 4);
    double y = cos(angle) * (radius - 4);
    return Stack(
      children: [
        Transform.rotate(
          angle: -pi / 2,
          child: ShaderMask(
            shaderCallback: (rect) {
              return SweepGradient(
                startAngle: 0,
                endAngle: 2 * pi,
                stops: [1 - progress, 1 - progress],
                center: Alignment.center,
                colors: [Colors.white, Colors.green],
              ).createShader(rect);
            },
            child: Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
