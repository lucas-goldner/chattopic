import 'package:chattopic/extensions/color_extension.dart';
import 'package:chattopic/helper/canvas_args.dart';
import 'package:chattopic/model/enum/favorite_color.dart';
import 'package:chattopic/ui/constants/ds_bar_constants.dart';
import 'package:flutter/material.dart';

class DSBottomBarBackgroundPainter extends CustomPainter {
  final FavoriteColor color;
  DSBottomBarBackgroundPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.getColor()
      // Strokewidth = 1 causes the underlying canvas layer to blend with this one.
      ..strokeWidth = 2;
    final CanvasArgs canvasArgs = CanvasArgs(canvas, size, paint);

    // Final border line.
    paint.color = Colors.black;
    canvas.drawLine(
      const Offset(0, 0),
      Offset(size.width, 0),
      paint,
    );

    int indexAtPixelRow = 62;

    for (double index = 0; index <= size.height; index++) {
      int intIndex = index.toInt();

      if (intIndex == DSBarConstants.reversedSections[7].stop ||
          intIndex == DSBarConstants.reversedSections.last.stop) {
        _pixelizedRow(
          canvasArgs,
          color.getColor().lighten(
                intIndex == indexAtPixelRow
                    ? DSBarConstants.reversedSections[7].lightenValue
                    : DSBarConstants.reversedSections[8].lightenValue,
              ),
          color.getColor().lighten(
                intIndex == indexAtPixelRow
                    ? DSBarConstants.reversedSections[8].lightenValue
                    : DSBarConstants.reversedSections.last.lightenValue,
              ),
          intIndex.toDouble(),
        );
      } else if (intIndex == DSBarConstants.reversedSections[4].stop) {
        _pixelizedTripleRow(
          canvasArgs,
          color
              .getColor()
              .lighten(DSBarConstants.reversedSections[3].lightenValue),
          color
              .getColor()
              .lighten(DSBarConstants.reversedSections[4].lightenValue),
          intIndex.toDouble(),
        );
      } else {
        _paintRow(index, color.getColor(), canvasArgs);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void _paintRow(
    double index,
    Color color,
    CanvasArgs canvasArgs,
  ) {
    final postion1 = Offset(0, index);
    final postion2 = Offset(canvasArgs.size.width, index);
    final section1 = DSBarConstants.reversedSections[1].stop;
    final section2 = DSBarConstants.reversedSections[2].stop;
    final section6 = DSBarConstants.reversedSections[6].stop;
    final section7 = DSBarConstants.reversedSections[7].stop;

    if (index < section1 &&
        index >= DSBarConstants.reversedSections.first.stop) {
      canvasArgs.paint.color = color;
      canvasArgs.canvas.drawLine(postion1, postion2, canvasArgs.paint);
    } else if (index < section2 && index > section1) {
      canvasArgs.paint.color =
          color.lighten(DSBarConstants.reversedSections[1].lightenValue);
      canvasArgs.canvas.drawLine(postion1, postion2, canvasArgs.paint);
    } else if (index < DSBarConstants.reversedSections[3].stop &&
        index > section2) {
      canvasArgs.paint.color =
          color.lighten(DSBarConstants.reversedSections[2].lightenValue);
      canvasArgs.canvas.drawLine(postion1, postion2, canvasArgs.paint);
    } else if (index < section7 && index > section6) {
      canvasArgs.paint.color =
          color.lighten(DSBarConstants.reversedSections[5].lightenValue);
      canvasArgs.canvas.drawLine(postion1, postion2, canvasArgs.paint);
    } else if (index < DSBarConstants.reversedSections[10].stop &&
        index > DSBarConstants.reversedSections[9].stop) {
      canvasArgs.paint.color =
          color.lighten(DSBarConstants.reversedSections[8].lightenValue);
      canvasArgs.canvas.drawLine(postion1, postion2, canvasArgs.paint);
    }
  }

  void _drawRect(Offset startPoint, Offset endPoint, CanvasArgs canvasArgs) {
    Rect rect = Rect.fromPoints(startPoint, endPoint);
    canvasArgs.canvas.drawRect(
      rect,
      canvasArgs.paint,
    );
  }

  void _pixelizedRow(
    CanvasArgs canvasArgs,
    Color color,
    Color lightenedColor,
    double yOffset,
  ) {
    double dashWidth = 4;
    double dashSpace = 4;
    double startX = 0;
    double startX2 = 4;
    Paint paint = canvasArgs.paint;

    // Draw squares X and Y ordered like
    // X Y
    // Y X
    while (startX < canvasArgs.size.width) {
      paint.color = color;
      final startPoint = Offset(startX, yOffset);
      final endPoint = Offset(startX + dashWidth, dashWidth + yOffset);
      _drawRect(startPoint, endPoint, canvasArgs);

      final startPoint2 = Offset(startX2, yOffset + dashWidth);
      final endPoint2 =
          Offset(startX2 + dashWidth, dashWidth + dashWidth + yOffset);
      _drawRect(startPoint2, endPoint2, canvasArgs);

      paint.color = lightenedColor;
      final startPoint3 = Offset(startX2, yOffset);
      final endPoint3 = Offset(startX2 + dashWidth, dashWidth + yOffset);
      _drawRect(startPoint3, endPoint3, canvasArgs);

      final startPoint4 = Offset(startX, dashWidth + yOffset);
      final endPoint4 =
          Offset(startX + dashWidth, dashWidth + dashWidth + yOffset);
      _drawRect(startPoint4, endPoint4, canvasArgs);

      startX += dashWidth + dashSpace;
      startX2 += dashWidth + dashSpace;
    }
  }

  void _pixelizedTripleRow(
    CanvasArgs canvasArgs,
    Color color,
    Color lightenedColor,
    double yOffset,
  ) {
    double dashWidth = 4;
    double dashSpace = 4;
    double startX = 0;
    double startX2 = 4;

    Paint paint = canvasArgs.paint;

    // Draw squares X and Y ordered like
    // X Y
    // Y X
    while (startX < canvasArgs.size.width) {
      paint.color = color;
      final startPoint = Offset(startX, yOffset);
      final endPoint = Offset(startX + dashWidth, dashWidth + yOffset);
      _drawRect(startPoint, endPoint, canvasArgs);

      final startPoint2 = Offset(startX2, yOffset + dashWidth);
      final endPoint2 =
          Offset(startX2 + dashWidth, dashWidth + dashWidth + yOffset);
      _drawRect(startPoint2, endPoint2, canvasArgs);

      final startPoint5 = Offset(startX, dashWidth + dashWidth + yOffset);
      final endPoint5 = Offset(
        startX + dashWidth,
        dashWidth + dashWidth + dashWidth + yOffset,
      );
      _drawRect(startPoint5, endPoint5, canvasArgs);

      paint.color = lightenedColor;
      final startPoint3 = Offset(startX2, yOffset);
      final endPoint3 = Offset(startX2 + dashWidth, dashWidth + yOffset);
      _drawRect(startPoint3, endPoint3, canvasArgs);

      final startPoint4 = Offset(startX, dashWidth + yOffset);
      final endPoint4 =
          Offset(startX + dashWidth, dashWidth + dashWidth + yOffset);
      _drawRect(startPoint4, endPoint4, canvasArgs);

      final startPoint6 = Offset(startX2, dashWidth + dashWidth + yOffset);
      final endPoint6 = Offset(
        startX2 + dashWidth,
        dashWidth + dashWidth + dashWidth + yOffset,
      );
      _drawRect(startPoint6, endPoint6, canvasArgs);

      startX += dashWidth + dashSpace;
      startX2 += dashWidth + dashSpace;
    }
  }
}
