import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class WorkoutSummaryScreen extends StatelessWidget {
  final String duration;
  final int calories;
  final double distanceKm;
  final int avgHeartRate;

  const WorkoutSummaryScreen({
    Key? key,
    required this.duration,
    required this.calories,
    this.distanceKm = 3.2,
    this.avgHeartRate = 74,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Trophy / Success Icon Container
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: AppColors.mint,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.emoji_events_rounded, color: AppColors.darkCard, size: 40),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                'Great Work!',
                style: GoogleFonts.outfit(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryText,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Workout session complete',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 16),

              // Progress Comparison Badge (+12%)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.lavender,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.trending_up_rounded, color: AppColors.darkCard, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      '+12% vs. previous workout',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkCard,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),

              // Summary Metrics Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.3,
                  children: [
                    _buildSummaryMetricCard(
                      label: 'Workout duration',
                      value: duration,
                      backgroundColor: Colors.white,
                    ),
                    _buildSummaryMetricCard(
                      label: 'Calories burned',
                      value: '$calories kcal',
                      backgroundColor: AppColors.softYellow,
                    ),
                    _buildSummaryMetricCard(
                      label: 'Total distance',
                      value: '${distanceKm.toStringAsFixed(1)} km',
                      backgroundColor: AppColors.mint,
                    ),
                    _buildSummaryMetricCard(
                      label: 'Avg Heart Rate',
                      value: '$avgHeartRate BPM',
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),

              // Action Buttons Row
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Return all the way to Home screen
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkCard,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Text(
                        'Done',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Text(
                      'View Detailed Statistics',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryMetricCard({
    required String label,
    required String value,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: backgroundColor == Colors.white ? AppColors.border : Colors.transparent,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
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
