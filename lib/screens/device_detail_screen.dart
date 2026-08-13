import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/app_header.dart';
import '../widgets/three_d_model_viewer.dart';
import 'workout_screen.dart';

class DeviceDetailScreen extends StatefulWidget {
  final int initialLevel;
  final Function(int) onStartWorkout;

  const DeviceDetailScreen({
    Key? key,
    this.initialLevel = 12,
    required this.onStartWorkout,
  }) : super(key: key);

  @override
  State<DeviceDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  late int _level;
  double _sliderValue = 0.5;

  @override
  void initState() {
    super.initState();
    _level = widget.initialLevel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            children: [
              // Header Row (Back, Calendar, Avatar)
              AppHeader(
                onBack: () => Navigator.pop(context),
                onCalendar: () {},
                onProfile: () {},
              ),
              const SizedBox(height: 12),

              // Top Section: Light Mint Card with 3D Model Showcase
              _buildTopMintCard(),
              const SizedBox(height: 18),

              // Bottom Section: Dual Card Layout (Dark Gauge Card + White Battery Slider Card)
              _buildBottomDualSection(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopMintCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: const Color(0xFFD3EBE4), // Soft Mint from Screen 3
        borderRadius: BorderRadius.circular(28.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subtitle Title & Vertical Toolbar Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Universal Fitness\nExpander',
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryText,
                  height: 1.15,
                ),
              ),

              // Right Vertical Floating Action Toolbar (Refresh, Stopwatch, Info)
              Column(
                children: [
                  _buildCircleToolbarButton(Icons.refresh_rounded),
                  const SizedBox(height: 8),
                  _buildCircleToolbarButton(Icons.timer_rounded),
                  const SizedBox(height: 8),
                  _buildCircleToolbarButton(Icons.info_outline_rounded),
                ],
              ),
            ],
          ),

          // Left Column (+ 12 PROGRAMS) & Center 3D Interactive Model Visualizer
          Stack(
            children: [
              // Metric Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '+',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryText,
                    ),
                  ),
                  Text(
                    '$_level',
                    style: GoogleFonts.outfit(
                      fontSize: 54,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryText,
                      height: 0.95,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.darkCard.withValues(alpha: 0.3), width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'PROGRAMS',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ),
                ],
              ),

              // Interactive 3D Model Renderer
              const ThreeDModelViewer(height: 190),
            ],
          ),
          const SizedBox(height: 12),

          // Bottom Row: Connected Pill + Model 2.0 Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Connected Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.activeGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Connected',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                'Model 2.0',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleToolbarButton(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18, color: AppColors.primaryText),
    );
  }

  Widget _buildBottomDualSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Large Dark Gauge Card
        Expanded(
          flex: 6,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.darkCard,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                // Top Header inside Left Dark Card
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    const Icon(Icons.more_vert_rounded, color: Colors.white, size: 18),
                  ],
                ),

                // Circular Gauge Ring (16 OF 30 MINS)
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 110,
                        height: 110,
                        child: CircularProgressIndicator(
                          value: 16 / 30,
                          strokeWidth: 10,
                          backgroundColor: Colors.white.withValues(alpha: 0.12),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFE9DDF2)),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '16',
                            style: GoogleFonts.outfit(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              height: 1.0,
                            ),
                          ),
                          Text(
                            'OF 30 MINS',
                            style: GoogleFonts.inter(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF8E8E93),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Subtext Row (↑ 5 Level, Star 5)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '↑ 5 Level',
                      style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star_border_rounded, size: 14, color: Colors.white),
                        const SizedBox(width: 2),
                        Text(
                          '5',
                          style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Side Jump Workout Tile with Go -> CTA
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      // Thumbnail
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=100&auto=format&fit=crop&q=80',
                          width: 36,
                          height: 36,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Side Jump',
                              style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primaryText),
                            ),
                            Text(
                              '12 Times',
                              style: GoogleFonts.inter(fontSize: 10, color: AppColors.secondaryText),
                            ),
                          ],
                        ),
                      ),

                      // Go Button
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkoutScreen(resistanceLevel: _level),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.mint,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Go',
                                style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.darkCard),
                              ),
                              const Icon(Icons.arrow_forward_rounded, size: 12, color: AppColors.darkCard),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Right White Battery & Vertical Slider Card
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Text(
                  '50%',
                  style: GoogleFonts.outfit(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryText,
                  ),
                ),
                Text(
                  'Battery',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 20),

                // Vertical Soft Lavender Slider Container
                Container(
                  width: 54,
                  height: 140,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.lavender.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(27),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (_level < 30) setState(() => _level++);
                        },
                        child: const Icon(Icons.keyboard_arrow_up_rounded, color: AppColors.darkCard),
                      ),
                      Container(
                        width: 32,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.darkCard,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_level > 1) setState(() => _level--);
                        },
                        child: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.darkCard),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
