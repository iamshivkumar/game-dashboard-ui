
import 'package:game_dashboard/utils/pallate.dart';
import 'package:vector_math/vector_math.dart' as vmath;

import 'package:flutter/material.dart';

class ProgressClipper extends CustomPainter {
  final double value;

  ProgressClipper(this.value);
  @override
  void paint(Canvas canvas, Size size) {
    // Get the center of the canvas 
    final center = Offset(size.width / 2, size.height / 2);
    

    canvas.drawCircle(
      center,
      size.width/2,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Pallate.teal.withOpacity(0.1)
        ..strokeWidth = 12,
    );

    canvas.save();


    canvas.drawArc(
      Rect.fromCenter(center: center, width: size.width, height: size.height),
      vmath.radians(-90),
      vmath.radians( 360*value),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..color = Pallate.teal
        ..strokeWidth = 12,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true ;
}
