import 'package:flutter/material.dart';

class CustomFabLocation extends FloatingActionButtonLocation {
  final double xOffset;
  final double yOffset;

  const CustomFabLocation(this.xOffset, this.yOffset);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabWidth = scaffoldGeometry.floatingActionButtonSize.width;
    final double screenWidth = scaffoldGeometry.scaffoldSize.width;
    final double x = screenWidth - (fabWidth) - 16.0;
    return Offset(
      x,
      scaffoldGeometry.scaffoldSize.height - yOffset,
    );
  }
}
