import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/app_header.dart';
import '../widgets/custom_device_painter.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final List<double> _hourlyValues = [1.2, 1.8, 1.0, 2.5, 3.0, 1.6];
  final List<String> _timeLabels = ['7am', '8am', '9am', '10am', '11am', '12am'];
  int _selectedBarIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            children: [
              // Top Header (Back, Calendar, Avatar)
              AppHeader(
                onBack: () {},
                onCalendar: () {},
                onProfile: () {},
              ),
              const SizedBox(height: 12),

              // Page Title (Statistics)
              Text(
                'Statistics',
                style: GoogleFonts.outfit(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryText,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 24),

              // Timeline Column (Lavender Card, Mint Card, Yellow Card with left vertical line)
              _buildTimelineSection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineSection() {
    return Column(
      children: [
        // Timeline Item 1: Lavender Active Time Card
        _buildTimelineItem(
          nodeIcon: Icons.check_circle_rounded,
          nodeColor: AppColors.darkCard,
          iconColor: Colors.white,
          card: _buildLavenderTimelineCard(),
        ),
        const SizedBox(height: 20),

        // Timeline Item 2: Mint Bar Chart Card
        _buildTimelineItem(
          nodeIcon: Icons.bar_chart_rounded,
          nodeColor: AppColors.mint,
          iconColor: AppColors.darkCard,
          card: _buildMintChartTimelineCard(),
        ),
        const SizedBox(height: 20),

        // Timeline Item 3: Soft Peach Summary Card
        _buildTimelineItem(
          nodeIcon: Icons.circle_outlined,
          nodeColor: AppColors.border,
          iconColor: AppColors.secondaryText,
          card: _buildSoftPeachTimelineCard(),
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required IconData nodeIcon,
    required Color nodeColor,
    required Color iconColor,
    required Widget card,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Timeline Node Dot & Line
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: nodeColor,
                shape: BoxShape.circle,
              ),
              child: Icon(nodeIcon, color: iconColor, size: 18),
            ),
            Container(
              width: 2,
              height: 140,
              color: AppColors.border.withValues(alpha: 0.8),
            ),
          ],
        ),
        const SizedBox(width: 14),

        // Right Card Container
        Expanded(child: card),
      ],
    );
  }

  Widget _buildLavenderTimelineCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lavender,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'July, 14 Sat',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
              Row(
                children: [
                  Text(
                    'View All',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryText,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(Icons.chevron_right_rounded, size: 16, color: AppColors.secondaryText),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Giant Metric 2.5H
          Text(
            '2.5H',
            style: GoogleFonts.outfit(
              fontSize: 44,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryText,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 16),

          // Duration Subtext Timeline
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1h 15 min',
                style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.secondaryText),
              ),
              Text(
                '1h 10 min',
                style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.secondaryText),
              ),
              Text(
                '25 min',
                style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.secondaryText),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Thick Segmented Line Indicator
          Row(
            children: [
              Expanded(
                flex: 45,
                child: Container(height: 5, decoration: BoxDecoration(color: AppColors.darkCard, borderRadius: BorderRadius.circular(3))),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 38,
                child: Container(height: 5, decoration: BoxDecoration(color: AppColors.darkCard.withValues(alpha: 0.6), borderRadius: BorderRadius.circular(3))),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 17,
                child: Container(height: 5, decoration: BoxDecoration(color: AppColors.darkCard.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(3))),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Dot Percentage Tags
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDotTag('45%'),
              _buildDotTag('38%'),
              _buildDotTag('17%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDotTag(String percentage) {
    return Row(
      children: [
        Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.primaryText, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(
          percentage,
          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primaryText),
        ),
      ],
    );
  }

  Widget _buildMintChartTimelineCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.mint,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'July, 14 Sat',
                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primaryText),
              ),
              Row(
                children: [
                  Text('View All', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.secondaryText)),
                  const SizedBox(width: 2),
                  const Icon(Icons.chevron_right_rounded, size: 16, color: AppColors.secondaryText),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Custom Bar Chart Area
          GestureDetector(
            onTapDown: (details) {
              final colWidth = (MediaQuery.of(context).size.width - 120) / _hourlyValues.length;
              final index = (details.localPosition.dx / colWidth).floor().clamp(0, _hourlyValues.length - 1);
              setState(() => _selectedBarIndex = index);
            },
            child: SizedBox(
              height: 110,
              child: CustomPaint(
                painter: MinimalActivityChartPainter(
                  values: _hourlyValues,
                  selectedIndex: _selectedBarIndex,
                ),
                child: Container(),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Time Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_timeLabels.length, (index) {
              return Text(
                _timeLabels[index],
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: index == _selectedBarIndex ? FontWeight.w800 : FontWeight.w500,
                  color: index == _selectedBarIndex ? AppColors.darkCard : AppColors.secondaryText,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSoftPeachTimelineCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.softYellow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'July, 14 Sat',
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primaryText),
          ),
          Row(
            children: [
              Text('View All', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.secondaryText)),
              const SizedBox(width: 2),
              const Icon(Icons.chevron_right_rounded, size: 16, color: AppColors.secondaryText),
            ],
          ),
        ],
      ),
    );
  }
}
