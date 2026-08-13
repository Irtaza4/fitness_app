import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/app_colors.dart';
import 'screens/home_screen.dart';
import 'screens/statistics_screen.dart';
import 'screens/devices_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/workout_screen.dart';

void main() {
  runApp(const FitnessApp());
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracking App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.darkCard,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.darkCard,
          background: AppColors.background,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
      ),
      home: const MainNavigationShell(),
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({Key? key}) : super(key: key);

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentTabIndex = 0;
  int _currentDeviceLevel = 12;
  bool _isReelFrameEnabled = false;

  void _onTabTapped(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  void _startWorkoutFromDevice(int level) {
    setState(() => _currentDeviceLevel = level);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutScreen(resistanceLevel: _currentDeviceLevel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(
        onNavigateTab: _onTabTapped,
        onStartWorkout: _startWorkoutFromDevice,
        currentLevel: _currentDeviceLevel,
      ),
      const StatisticsScreen(),
      DevicesScreen(
        onStartWorkout: _startWorkoutFromDevice,
        currentLevel: _currentDeviceLevel,
      ),
      const ProfileScreen(),
    ];

    Widget mainContent = Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentTabIndex,
        children: pages,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );

    // If Reel presentation mode is enabled, wrap the mobile screen inside an iPhone 16 Pro mockup frame!
    if (_isReelFrameEnabled) {
      return Scaffold(
        backgroundColor: const Color(0xFF0F0F11),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1C1C1E),
          elevation: 0,
          title: Text(
            'Instagram Reel Mode (iPhone Frame)',
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          actions: [
            TextButton.icon(
              onPressed: () => setState(() => _isReelFrameEnabled = false),
              icon: const Icon(Icons.fullscreen_rounded, color: Colors.white, size: 18),
              label: Text('Full Screen', style: GoogleFonts.inter(color: Colors.white, fontSize: 12)),
            ),
          ],
        ),
        body: Center(
          child: Container(
            width: 390,
            height: 820,
            margin: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(48),
              border: Border.all(color: const Color(0xFF2C2C2E), width: 10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 40,
                  spreadRadius: 4,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(38),
              child: Stack(
                children: [
                  mainContent,

                  // Dynamic Island Top Pill
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 110,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Standard Full Screen View with a floating top toggle for Insta Reel frame
    return Stack(
      children: [
        mainContent,

        // Floating Reel Frame Mode Toggle Button
        Positioned(
          top: 48,
          right: 16,
          child: GestureDetector(
            onTap: () => setState(() => _isReelFrameEnabled = !_isReelFrameEnabled),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.darkCard.withOpacity(0.85),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.phone_iphone_rounded, color: Colors.white, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    'Reel Frame',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(index: 0, icon: Icons.grid_view_rounded, label: 'Home'),
          _buildNavItem(index: 1, icon: Icons.bar_chart_rounded, label: 'Statistics'),
          _buildNavItem(index: 2, icon: Icons.devices_rounded, label: 'Devices'),
          _buildNavItem(index: 3, icon: Icons.person_rounded, label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = index == _currentTabIndex;

    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.darkCard : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppColors.secondaryText,
              size: 20,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
