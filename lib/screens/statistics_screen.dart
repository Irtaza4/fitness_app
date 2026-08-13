import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_device_painter.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int _selectedPeriodIndex = 1; // 0: Today, 1: Week, 2: Month
  final List<String> _periods = ['Today', 'Week', 'Month'];
  int _selectedChartDay = 3; // Thursday

  final List<double> _weeklyHours = [1.8, 2.1, 1.4, 2.5, 3.0, 2.2, 1.9];
  final List<String> _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Statistics',
                style: GoogleFonts.outfit(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryText,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 16),

              // Date Selector Row
              _buildDateSelectorRow(),
              const SizedBox(height: 20),

              // Primary Metric Card (Lavender Accent)
              _buildPrimaryLavenderCard(),
              const SizedBox(height: 20),

              // Activity Chart Card (Mint Accent)
              _buildActivityMintChartCard(),
              const SizedBox(height: 24),

              // Section Title
              Text(
                'Overview',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 14),

              // Secondary Statistics Stacked Grid
              _buildSecondaryStatisticsGrid(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelectorRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Period Segmented Control
        Container(
          height: 38,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColors.pillBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: List.generate(_periods.length, (index) {
              final isSelected = index == _selectedPeriodIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedPeriodIndex = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.darkCard : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      _periods[index],
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : AppColors.secondaryText,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        // Date Range Selector
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const Icon(Icons.chevron_left_rounded, size: 18, color: AppColors.secondaryText),
              const SizedBox(width: 4),
              Text(
                'Aug 13',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.secondaryText),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryLavenderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: AppColors.lavender,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TOTAL ACTIVE TIME',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                  color: AppColors.primaryText.withOpacity(0.6),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.trending_up_rounded, size: 14, color: AppColors.darkCard),
                    const SizedBox(width: 4),
                    Text(
                      '+14%',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkCard,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '2.5H',
            style: GoogleFonts.outfit(
              fontSize: 46,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryText,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Active time this week • Goal: 3.0H/day',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryText.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 18),

          // Thin Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.83,
              minHeight: 6,
              backgroundColor: Colors.white.withOpacity(0.5),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.darkCard),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityMintChartCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: AppColors.mint,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Activity This Week',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
              Text(
                'Avg 2.1h/day',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText.withOpacity(0.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Custom Bar Chart Area
          GestureDetector(
            onTapDown: (details) {
              final width = MediaQuery.of(context).size.width - 84;
              final colWidth = width / _weeklyHours.length;
              final tappedIndex = (details.localPosition.dx / colWidth).floor().clamp(0, _weeklyHours.length - 1);
              setState(() => _selectedChartDay = tappedIndex);
            },
            child: SizedBox(
              height: 130,
              child: CustomPaint(
                painter: MinimalActivityChartPainter(
                  values: _weeklyHours,
                  selectedIndex: _selectedChartDay,
                ),

                child: Container(),
              ),
            ),
          ),

          // Day Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_days.length, (index) {
              final isSelected = index == _selectedChartDay;
              return Container(
                width: 28,
                alignment: Alignment.center,
                child: Text(
                  _days[index],
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                    color: isSelected ? AppColors.darkCard : AppColors.secondaryText,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryStatisticsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildSecondaryStatTile(
                icon: Icons.local_fire_department_rounded,
                title: 'Calories',
                value: '1,842 kcal',
                trend: '+8%',
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _buildSecondaryStatTile(
                icon: Icons.map_rounded,
                title: 'Distance',
                value: '7.4 km',
                trend: '+12%',
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _buildSecondaryStatTile(
                icon: Icons.access_time_filled_rounded,
                title: 'Active Time',
                value: '2h 32m',
                trend: '+5%',
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _buildSecondaryStatTile(
                icon: Icons.favorite_rounded,
                title: 'Heart Rate',
                value: '74 BPM',
                trend: 'Normal',
                iconColor: const Color(0xFFFF2D55),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecondaryStatTile({
    required IconData icon,
    required String title,
    required String value,
    required String trend,
    Color iconColor = AppColors.darkCard,
  }) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: iconColor, size: 22),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.pillBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  trend,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
