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
          surface: AppColors.background,
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
  bool _isDarkMode = false;

  void _onTabTapped(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  void _toggleDarkMode(bool val) {
    setState(() {
      _isDarkMode = val;
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
    final backgroundColor = _isDarkMode ? const Color(0xFF0E0E10) : AppColors.background;
    final navBarColor = _isDarkMode ? const Color(0xFF1B1B1E) : Colors.white;
    final navBarBorderColor = _isDarkMode ? Colors.white.withValues(alpha: 0.1) : AppColors.border;

    final List<Widget> pages = [
      HomeScreen(
        onNavigateTab: _onTabTapped,
        onStartWorkout: _startWorkoutFromDevice,
        currentLevel: _currentDeviceLevel,
        isDarkMode: _isDarkMode,
      ),
      const StatisticsScreen(),
      DevicesScreen(
        onStartWorkout: _startWorkoutFromDevice,
        currentLevel: _currentDeviceLevel,
      ),
      ProfileScreen(
        isDarkMode: _isDarkMode,
        onToggleDarkMode: _toggleDarkMode,
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: IndexedStack(
        index: _currentTabIndex,
        children: pages,
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 78,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: navBarColor,
          border: Border(
            top: BorderSide(color: navBarBorderColor, width: 1),
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
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = index == _currentTabIndex;
    final activePillColor = _isDarkMode
        ? (isSelected ? AppColors.mint : Colors.transparent)
        : (isSelected ? AppColors.darkCard : Colors.transparent);
    final activeTextColor = _isDarkMode
        ? (isSelected ? AppColors.darkCard : Colors.white.withValues(alpha: 0.6))
        : (isSelected ? Colors.white : AppColors.secondaryText);

    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: activePillColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: activeTextColor,
              size: 20,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.outfit(
                  color: activeTextColor,
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
