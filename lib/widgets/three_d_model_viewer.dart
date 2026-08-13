import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Interactive 3D Model Visualizer & Explosive Assembly Showcase
class ThreeDModelViewer extends StatefulWidget {
  final double height;
  final String modelName;

  const ThreeDModelViewer({
    Key? key,
    this.height = 220,
    this.modelName = 'Universal Expander 3D',
  }) : super(key: key);

  @override
  State<ThreeDModelViewer> createState() => _ThreeDModelViewerState();
}

class _ThreeDModelViewerState extends State<ThreeDModelViewer> with SingleTickerProviderStateMixin {
  double _yaw = 0.4;   // Rotation Y
  double _pitch = 0.2; // Rotation X

  late AnimationController _animController;
  late Animation<double> _assemblyAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _assemblyAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack,
    );

    _animController.addListener(() {
      if (mounted) setState(() {});
    });

    // Automatically trigger explosion and assembly sequence
    _triggerAssemblySequence();
  }

  void _triggerAssemblySequence() {
    _animController.reset();
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final assemblyProgress = _assemblyAnimation.value; // 0.0 (Dismantled) -> 1.0 (Assembled)

    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _yaw += details.delta.dx * 0.01;
          _pitch += details.delta.dy * 0.01;
          _pitch = _pitch.clamp(-0.6, 0.6);
        });
      },
      onTap: _triggerAssemblySequence,
      child: SizedBox(
        height: widget.height,
        width: double.infinity,
        child: CustomPaint(
          size: Size(double.infinity, widget.height),
          painter: CinematicProduct3DPainter(
            yaw: _yaw,
            pitch: _pitch,
            assemblyProgress: assemblyProgress,
          ),
        ),
      ),
    );
  }
}

/// Custom 3D Painter capable of dismantling and assembling product components in 3D perspective
class CinematicProduct3DPainter extends CustomPainter {
  final double yaw;
  final double pitch;
  final double assemblyProgress; // 0.0 to 1.0

  CinematicProduct3DPainter({
    required this.yaw,
    required this.pitch,
    required this.assemblyProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Dynamic exploded offsets (Parts fly in from 3D space)
    final explodeFactor = (1.0 - assemblyProgress);

    // Floor Shadow
    final shadowOpacity = (0.35 * assemblyProgress).clamp(0.0, 0.35);
    final shadowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.black.withValues(alpha: shadowOpacity),
          Colors.black.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: Offset(center.dx, size.height - 15), radius: 90));
    canvas.drawOval(
      Rect.fromCenter(center: Offset(center.dx, size.height - 15), width: 170 * assemblyProgress, height: 22),
      shadowPaint,
    );

    // 1. Center Metallic Coupling Rod (Flies from top offset)
    final rodOffset = Offset(center.dx, center.dy - (60 * explodeFactor));
    _drawCenterRod(canvas, rodOffset, explodeFactor);

    // 2. Controller 1 — Left Ergonomic Mint Shell (Flies from top left)
    final c1Offset = Offset(
      center.dx - 35 - (55 * explodeFactor) + (math.sin(yaw) * 12),
      center.dy - 10 - (30 * explodeFactor) + (math.cos(pitch) * 8),
    );
    _draw3DControllerShell(
      canvas: canvas,
      center: c1Offset,
      rotation: yaw + (explodeFactor * 0.8),
      colorStart: const Color(0xFFAEE3D7),
      colorEnd: const Color(0xFF5CA395),
      scale: 1.15,
      isLeft: true,
      explodeFactor: explodeFactor,
    );

    // 3. Controller 2 — Right Ergonomic Mint Shell (Flies from bottom right)
    final c2Offset = Offset(
      center.dx + 45 + (60 * explodeFactor) - (math.sin(yaw) * 12),
      center.dy + 15 + (35 * explodeFactor) - (math.cos(pitch) * 8),
    );
    _draw3DControllerShell(
      canvas: canvas,
      center: c2Offset,
      rotation: yaw + 0.8 - (explodeFactor * 0.6),
      colorStart: const Color(0xFF437A70),
      colorEnd: const Color(0xFF274D46),
      scale: 1.0,
      isLeft: false,
      explodeFactor: explodeFactor,
    );
  }

  void _drawCenterRod(Canvas canvas, Offset center, double explode) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(yaw * 0.3);

    final rect = Rect.fromCenter(center: Offset.zero, width: 22, height: 80);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(11));

    final rodPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF3A3A3C), Color(0xFF1C1C1E), Color(0xFF121212)],
      ).createShader(rect);

    canvas.drawRRect(rrect, rodPaint);
    canvas.restore();
  }

  void _draw3DControllerShell({
    required Canvas canvas,
    required Offset center,
    required double rotation,
    required Color colorStart,
    required Color colorEnd,
    required double scale,
    required bool isLeft,
    required double explodeFactor,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation * 0.4);
    canvas.scale(scale);

    final rect = Rect.fromCenter(center: Offset.zero, width: 66, height: 126);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(33));

    // Metallic Mint Gradient
    final bodyPaint = Paint()
      ..shader = LinearGradient(
        colors: [colorStart, colorEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);

    // Rim highlight
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2;

    canvas.drawRRect(rrect, bodyPaint);
    canvas.drawRRect(rrect, highlightPaint);

    // Separated Button Module (Snaps into handle)
    final buttonOffset = isLeft ? Offset(-15 * explodeFactor, -25 - (15 * explodeFactor)) : Offset(15 * explodeFactor, -25 - (15 * explodeFactor));
    final buttonPanelRect = Rect.fromCenter(center: buttonOffset, width: 32, height: 40);
    final buttonPanelRRect = RRect.fromRectAndRadius(buttonPanelRect, const Radius.circular(16));
    final panelPaint = Paint()..color = Colors.black.withValues(alpha: 0.2);
    canvas.drawRRect(buttonPanelRRect, panelPaint);

    // Button Dots
    final dotPaint = Paint()..color = Colors.white.withValues(alpha: 0.9);
    canvas.drawCircle(buttonOffset + const Offset(0, -7), 3.5, dotPaint);
    canvas.drawCircle(buttonOffset + const Offset(0, 7), 3.5, dotPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CinematicProduct3DPainter oldDelegate) =>
      oldDelegate.yaw != yaw || oldDelegate.pitch != pitch || oldDelegate.assemblyProgress != assemblyProgress;
}
