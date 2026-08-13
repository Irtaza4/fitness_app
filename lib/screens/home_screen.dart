import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/app_header.dart';
import 'device_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) onNavigateTab;
  final Function(int) onStartWorkout;
  final int currentLevel;

  const HomeScreen({
    Key? key,
    required this.onNavigateTab,
    required this.onStartWorkout,
    this.currentLevel = 12,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0; // 0: Connection, 1: Statistics, 2: Shop
  final List<String> _categories = ['Connection', 'Statistics', 'Shop'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top App Header (Back, Calendar, Avatar)
                    AppHeader(
                      onBack: () {},
                      onCalendar: () {},
                      onProfile: () => widget.onNavigateTab(3),
                    ),
                    const SizedBox(height: 16),

                    // Page Title (Fitness Tracking Device)
                    Text(
                      'Fitness\nTracking Device',
                      style: GoogleFonts.outfit(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryText,
                        height: 1.1,
                        letterSpacing: -0.8,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Category Segmented Control (Connection, Statistics, Shop)
                    _buildCategoryPillSelector(),
                    const SizedBox(height: 24),

                    // Hero Card (Universal Fitness Expander - Dark Card with Stacked Layer Edge)
                    _buildHeroDarkCard(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Floating Bottom Navigation Capsule Bar (Connect >>)
            _buildFloatingBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryPillSelector() {
    return Row(
      children: List.generate(_categories.length, (index) {
        final isSelected = index == _selectedCategoryIndex;
        return Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () {
              setState(() => _selectedCategoryIndex = index);
              if (index == 1) widget.onNavigateTab(1); // Statistics
              if (index == 2) widget.onNavigateTab(2); // Devices / Shop
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.darkCard : Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Text(
                _categories[index],
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.primaryText,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeroDarkCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeviceDetailScreen(
              initialLevel: widget.currentLevel,
              onStartWorkout: widget.onStartWorkout,
            ),
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Layered Soft Lavender Card Top Edge (Visual Depth Effect)
          Positioned(
            top: -12,
            left: 20,
            right: 20,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.lavender,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),

          // Main Dark Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: AppColors.darkCard,
              borderRadius: BorderRadius.circular(28.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row inside Card
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Subtitle Name
                    Text(
                      'Universal\nFitness\nExpander',
                      style: GoogleFonts.outfit(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.15,
                      ),
                    ),

                    // QR Scan Badge
                    Row(
                      children: [
                        Text(
                          'Scan the\ndevice\'s QR\nto connect',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF8E8E93),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.qr_code_2_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Main Content Row (Metric + Product Photo Box)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left Metric Column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '+',
                          style: GoogleFonts.outfit(
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                            height: 1.0,
                          ),
                        ),
                        Text(
                          '${widget.currentLevel}',
                          style: GoogleFonts.outfit(
                            fontSize: 68,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 0.95,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Outlined PROGRAMS Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'PROGRAMS',
                            style: GoogleFonts.inter(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Right Product Photo Card (User holding 3D mint expander handles)
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=400&auto=format&fit=crop&q=80',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: const Color(0xFFAEE3D7),
                            child: const Center(
                              child: Icon(Icons.fitness_center_rounded, color: AppColors.darkCard, size: 48),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Pagination Dots Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    final isSelected = index == 4;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isSelected ? 8 : 5,
                      height: isSelected ? 8 : 5,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingBottomBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Icon Button
          GestureDetector(
            onTap: () => widget.onNavigateTab(2), // Go to Devices
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.sports_rounded, color: AppColors.darkCard, size: 20),
            ),
          ),

          // Center Connect >> Action
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeviceDetailScreen(
                    initialLevel: widget.currentLevel,
                    onStartWorkout: widget.onStartWorkout,
                  ),
                ),
              );
            },
            child: Row(
              children: [
                Text(
                  'Connect >>',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // Right Icon Button
          GestureDetector(
            onTap: () => widget.onNavigateTab(1), // Go to Statistics
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.tune_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
