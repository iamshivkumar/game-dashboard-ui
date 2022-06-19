import 'package:flutter/material.dart';

class TileCard extends StatelessWidget {
  const TileCard(
      {Key? key, required this.child, required this.color, this.right = false})
      : super(key: key);
  final Color color;
  final Widget child;
  final bool right;
  @override
  Widget build(BuildContext context) {
    final colors = [
      color.withOpacity(0.2),
      color.withOpacity(0.1),
      Colors.transparent
    ];
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: right
              ? BorderSide(
                  color: color,
                  width: 4,
                )
              : BorderSide.none,
          left: right
              ? BorderSide.none
              : BorderSide(
                  color: color,
                  width: 4,
                ),
        ),
        gradient: LinearGradient(
          colors: right ? colors.reversed.toList() : colors,
        ),
      ),
      child: child,
    );
  }
}
