import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Custom Painter for the Universal Fitness Expander Hero Device
class UniversalExpanderPainter extends CustomPainter {
  final double accentLevel;
  UniversalExpanderPainter({this.accentLevel = 12});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Floor Shadow Gradient
    final shadowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.black.withOpacity(0.35),
          Colors.black.withOpacity(0.0),
        ],
      ).createShader(Rect.fromCircle(center: Offset(center.dx, size.height - 15), radius: size.width * 0.4));
    canvas.drawOval(
      Rect.fromCenter(center: Offset(center.dx, size.height - 15), width: size.width * 0.8, height: 24),
      shadowPaint,
    );

    // Resistance Bands (Curved Arcs)
    final bandPaint = Paint()
      ..color = const Color(0xFF3A3A3C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    final bandAccentPaint = Paint()
      ..color = const Color(0xFF545458)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(25, size.height * 0.55)
      ..cubicTo(
        size.width * 0.25, size.height * 0.1,
        size.width * 0.75, size.height * 0.1,
        size.width - 25, size.height * 0.55,
      );

    canvas.drawPath(path, bandPaint);
    canvas.drawPath(path, bandAccentPaint);

    // Center Control Module (Dark Metal Box)
    final moduleRect = Rect.fromCenter(
      center: Offset(center.dx, size.height * 0.38),
      width: 100,
      height: 60,
    );
    final moduleRRect = RRect.fromRectAndRadius(moduleRect, const Radius.circular(16));

    final modulePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF2C2C2E), Color(0xFF1C1C1E), Color(0xFF121212)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(moduleRect);
    final moduleBorderPaint = Paint()
      ..color = const Color(0xFF48484A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawRRect(moduleRRect, modulePaint);
    canvas.drawRRect(moduleRRect, moduleBorderPaint);

    // Digital Screen inside Module
    final screenRect = Rect.fromCenter(
      center: Offset(center.dx, size.height * 0.38),
      width: 72,
      height: 38,
    );
    final screenRRect = RRect.fromRectAndRadius(screenRect, const Radius.circular(10));
    final screenPaint = Paint()..color = Colors.black;
    canvas.drawRRect(screenRRect, screenPaint);

    // Active Green Connection Dot
    final dotPaint = Paint()..color = const Color(0xFF30D158);
    canvas.drawCircle(Offset(center.dx - 22, size.height * 0.38 - 8), 3, dotPaint);

    // Text representation drawn on screen
    final textPainter = TextPainter(
      text: TextSpan(
        text: "LVL ${accentLevel.toInt()}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2 + 5, size.height * 0.38 - textPainter.height / 2 - 2),
    );

    final subTextPainter = TextPainter(
      text: const TextSpan(
        text: "CONNECTED",
        style: TextStyle(
          color: Color(0xFF30D158),
          fontSize: 7,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    subTextPainter.layout();
    subTextPainter.paint(
      canvas,
      Offset(center.dx - subTextPainter.width / 2, size.height * 0.38 + 5),
    );

    // Left Grip Handle
    _drawHandle(canvas, Offset(25, size.height * 0.55 + 15));

    // Right Grip Handle
    _drawHandle(canvas, Offset(size.width - 25, size.height * 0.55 + 15));
  }

  void _drawHandle(Canvas canvas, Offset center) {
    final handleRect = Rect.fromCenter(center: center, width: 32, height: 64);
    final handleRRect = RRect.fromRectAndRadius(handleRect, const Radius.circular(10));
    final handlePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF3A3A3C), Color(0xFF1C1C1E)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(handleRect);
    canvas.drawRRect(handleRRect, handlePaint);

    final ridgePaint = Paint()
      ..color = const Color(0xFF545458)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (int i = -2; i <= 2; i++) {
      canvas.drawLine(
        Offset(center.dx - 10, center.dy + (i * 10)),
        Offset(center.dx + 10, center.dy + (i * 10)),
        ridgePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant UniversalExpanderPainter oldDelegate) =>
      oldDelegate.accentLevel != accentLevel;
}

/// Custom Painter for Smart Dumbbell
class SmartDumbbellPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Shaft
    final shaftRect = Rect.fromCenter(center: center, width: size.width * 0.5, height: 18);
    final shaftRRect = RRect.fromRectAndRadius(shaftRect, const Radius.circular(6));
    final shaftPaint = Paint()..color = const Color(0xFF2C2C2E);
    canvas.drawRRect(shaftRRect, shaftPaint);

    // Weight Plates Left
    final platePaint = Paint()..color = const Color(0xFF1C1C1E);
    final outerPlatePaint = Paint()..color = const Color(0xFF111111);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(center.dx - size.width * 0.22, center.dy), width: 22, height: size.height * 0.75),
        const Radius.circular(8),
      ),
      platePaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(center.dx - size.width * 0.32, center.dy), width: 16, height: size.height * 0.6),
        const Radius.circular(6),
      ),
      outerPlatePaint,
    );

    // Weight Plates Right
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(center.dx + size.width * 0.22, center.dy), width: 22, height: size.height * 0.75),
        const Radius.circular(8),
      ),
      platePaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(center.dx + size.width * 0.32, center.dy), width: 16, height: size.height * 0.6),
        const Radius.circular(6),
      ),
      outerPlatePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom Painter for Minimalist Activity Bar Chart
class MinimalActivityChartPainter extends CustomPainter {
  final List<double> values;
  final int selectedIndex;

  MinimalActivityChartPainter({
    required this.values,
    this.selectedIndex = 3, // Default Thursday highlighted
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final barWidth = (size.width / values.length) - 12;
    final maxVal = values.reduce(math.max);

    for (int i = 0; i < values.length; i++) {
      final barHeight = (values[i] / maxVal) * (size.height - 35);
      final isSelected = i == selectedIndex;

      final x = (i * (barWidth + 12)) + 6;
      final y = size.height - 25 - barHeight;

      final barRect = Rect.fromLTWH(x, y, barWidth, barHeight);
      final barRRect = RRect.fromRectAndRadius(barRect, const Radius.circular(8));

      final barPaint = Paint()
        ..color = isSelected ? const Color(0xFF171717) : const Color(0xFF171717).withOpacity(0.18);

      canvas.drawRRect(barRRect, barPaint);

      // Tooltip pill on selected bar
      if (isSelected) {
        final tooltipRect = Rect.fromCenter(
          center: Offset(x + barWidth / 2, y - 14),
          width: 38,
          height: 18,
        );
        final tooltipRRect = RRect.fromRectAndRadius(tooltipRect, const Radius.circular(6));
        final tooltipPaint = Paint()..color = const Color(0xFF171717);
        canvas.drawRRect(tooltipRRect, tooltipPaint);

        final textPainter = TextPainter(
          text: TextSpan(
            text: "${values[i].toStringAsFixed(1)}h",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(x + barWidth / 2 - textPainter.width / 2, y - 14 - textPainter.height / 2),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant MinimalActivityChartPainter oldDelegate) =>
      oldDelegate.selectedIndex != selectedIndex || oldDelegate.values != values;
}
