import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

/// A widget that clips its child using a polygon with its number of sides equal to [sides], rotated by [rotate] degrees.
///
/// To round the edges of the polygon, pass the desired angle to [borderRadius].
/// There is a known issue where adding a [borderRadius] will reduce the size of the polygon.
class ClipPolygon extends StatelessWidget {
  final Widget? child;
  final int sides;
  final double rotate;
  final double borderRadius;
  final List<PolygonBoxShadow> boxShadows;

  /// Creates a polygon shaped clip with [sides] sides rotated [rotate] degrees.
  ///
  /// Provide a [borderRadius] to set the radius of the corners.
  ///
  /// The [sides] argument must be at least 3.
  const ClipPolygon(
      {Key? key,
      required this.sides,
      this.rotate: 0.0,
      this.borderRadius: 0.0,
      this.boxShadows: const [],
      this.child})
      : assert(sides >= 3),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    PolygonPathSpecs specs = PolygonPathSpecs(
      sides: sides < 3 ? 3 : sides,
      rotate: rotate,
      borderRadiusAngle: borderRadius,
    );

    return AspectRatio(
        aspectRatio: 1.0,
        child: CustomPaint(
            painter: PolygonBoxShadowPainter(specs, boxShadows),
            child: ClipPath(
              clipper: PolygonClipper(specs),
              child: child,
            )));
  }
}

/// Provides polygon shaped clips based on [PolygonPathSpecs]
class PolygonClipper extends CustomClipper<Path> {
  final PolygonPathSpecs specs;

  /// Create a polygon clipper with the provided specs.
  PolygonClipper(this.specs);

  @override
  Path getClip(Size size) {
    return PolygonPathDrawer(size: size, specs: specs).draw();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

/// A polygon shaped shadow
class PolygonBoxShadowPainter extends CustomPainter {
  final PolygonPathSpecs specs;
  final List<PolygonBoxShadow> boxShadows;

  /// Creates a polygon shaped shadow
  PolygonBoxShadowPainter(this.specs, this.boxShadows);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = PolygonPathDrawer(size: size, specs: specs).draw();

    boxShadows.forEach((PolygonBoxShadow shadow) {
      canvas.drawShadow(path, shadow.color, shadow.elevation, false);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

/// Specifications of a polygon box shadow
class PolygonBoxShadow {
  final Color color;
  final double elevation;

  /// Creates a polygon box shadow with the provided [color] and [elevation].
  PolygonBoxShadow({
    required this.color,
    required this.elevation,
  });
}

class PolygonPathDrawer {
  final Size size;
  final PolygonPathSpecs specs;

  /// Creates a polygon path drawer.
  PolygonPathDrawer({
    required this.size,
    required this.specs,
  });

  Path draw() {
    final anglePerSide = 360 / specs.sides;

    final radius = (size.width - specs.borderRadiusAngle) / 2;
    final arcLength =
        (radius * _angleToRadian(specs.borderRadiusAngle)) + (specs.sides * 2);

    Path path = Path();

    for (var i = 0; i <= specs.sides; i++) {
      double currentAngle = anglePerSide * i;
      bool isFirst = i == 0;

      if (specs.borderRadiusAngle > 0) {
        _drawLineAndArc(path, currentAngle, radius, arcLength, isFirst);
      } else {
        _drawLine(path, currentAngle, radius, isFirst);
      }
    }

    return path;
  }

  _drawLine(Path path, double currentAngle, double radius, bool move) {
    Offset current = _getOffset(currentAngle, radius);

    if (move)
      path.moveTo(current.dx, current.dy);
    else
      path.lineTo(current.dx, current.dy);
  }

  _drawLineAndArc(Path path, double currentAngle, double radius,
      double arcLength, bool isFirst) {
    double prevAngle = currentAngle - specs.halfBorderRadiusAngle;
    double nextAngle = currentAngle + specs.halfBorderRadiusAngle;

    Offset previous = _getOffset(prevAngle, radius);
    Offset next = _getOffset(nextAngle, radius);

    if (isFirst) {
      path.moveTo(next.dx, next.dy);
    } else {
      path.lineTo(previous.dx, previous.dy);
      path.arcToPoint(next, radius: Radius.circular(arcLength));
    }
  }

  double _angleToRadian(double angle) {
    return angle * (pi / 180);
  }

  Offset _getOffset(double angle, double radius) {
    final rotationAwareAngle = angle - 90 + specs.rotate;

    final radian = _angleToRadian(rotationAwareAngle);
    final x = cos(radian) * radius + radius + specs.halfBorderRadiusAngle;
    final y = sin(radian) * radius + radius + specs.halfBorderRadiusAngle;

    return Offset(x, y);
  }
}

/// Specs class for polygon paths.
class PolygonPathSpecs {
  final int sides;
  final double rotate;
  final double borderRadiusAngle;
  final double halfBorderRadiusAngle;

  /// Creates polygon path specs.
  PolygonPathSpecs({
    required this.sides,
    required this.rotate,
    required this.borderRadiusAngle,
  })   : halfBorderRadiusAngle = borderRadiusAngle / 2,
        assert(sides >= 3);
}





/// A border that fits a polygon-shaped border with its number of sides equal to [sides], rotated by [rotate] degrees
/// within the rectangle of the widget it is applied to.
///
/// To round the edges of the polygon, pass the desired angle to [borderRadius].
/// There is a known issue where adding a [borderRadius] will reduce the size of the polygon.
///
/// See also:
///
///  * [BorderSide], which is used to describe the border of the polygon.
class PolygonBorder extends OutlinedBorder {
  final int sides;
  final double rotate;
  final double borderRadius;

  /// Create a PolygonBorder number of sides equal to [sides], rotated by [rotate] degrees.
  ///
  /// Provide a [borderRadius] to set the radius of the corners.
  ///
  /// Use [side] to define the outline's color and weight.
  /// If [side] is [BorderSide.none], which is the default, an outline is not drawn.
  /// Otherwise the outline is centered over the shape's boundary.
  ///
  /// [sides] should be at least 3.
  ///
  /// All variables must not be null.
  const PolygonBorder({
    required this.sides,
    this.rotate = 0.0,
    this.borderRadius = 0.0,
    BorderSide side = BorderSide.none,
  })  : assert(sides >= 2),
        super(side: side);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  Path _getPath(Rect rect, double radius) {
    var specs = PolygonPathSpecs(
      sides: sides < 3 ? 3 : sides,
      rotate: rotate,
      borderRadiusAngle: borderRadius,
    );

    return PolygonPathDrawer(size: Size.fromRadius(radius), specs: specs)
        .draw()
        .shift(Offset(rect.center.dx - radius, rect.center.dy - radius));
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is PolygonBorder && a.sides == sides) {
      return PolygonBorder(
        sides: sides,
        rotate: lerpDouble(a.rotate, rotate, t)!,
        borderRadius: lerpDouble(a.borderRadius, borderRadius, t)!,
        side: BorderSide.lerp(a.side, side, t),
      );
    } else {
      return super.lerpFrom(a, t);
    }
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is PolygonBorder && b.sides == sides) {
      return PolygonBorder(
        sides: sides,
        rotate: lerpDouble(rotate, b.rotate, t)!,
        borderRadius: lerpDouble(borderRadius, b.borderRadius, t)!,
        side: BorderSide.lerp(side, b.side, t),
      );
    } else {
      return super.lerpTo(b, t);
    }
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        var radius = (rect.shortestSide - side.width) / 2.0;
        var path = _getPath(rect, radius);
        canvas.drawPath(path, side.toPaint());
        break;
    }
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect, max(0.0, rect.shortestSide / 2.0 - side.width));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return _getPath(rect, max(0.0, rect.shortestSide / 2.0));
  }

  @override
  ShapeBorder scale(double t) {
    return PolygonBorder(
        sides: sides,
        rotate: rotate,
        borderRadius: borderRadius * t,
        side: side.scale(t));
  }

  @override
  int get hashCode {
    return sides.hashCode ^
        rotate.hashCode ^
        borderRadius.hashCode ^
        side.hashCode;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PolygonBorder &&
              runtimeType == other.runtimeType &&
              sides == other.sides &&
              side == other.side &&
              rotate == other.rotate &&
              borderRadius == other.borderRadius;

  @override
  OutlinedBorder copyWith({BorderSide? side}) {
    if (side == null) return this;
    return PolygonBorder(
      sides: sides,
      side: side,
      rotate: rotate,
      borderRadius: borderRadius,
    );
  }
}