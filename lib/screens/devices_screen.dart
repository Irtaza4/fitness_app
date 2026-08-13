import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../models/fitness_data.dart';
import 'device_detail_screen.dart';

class DevicesScreen extends StatefulWidget {
  final Function(int) onStartWorkout;
  final int currentLevel;

  const DevicesScreen({
    Key? key,
    required this.onStartWorkout,
    this.currentLevel = 12,
  }) : super(key: key);

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  int _selectedFilterIndex = 0; // 0: All, 1: Connected, 2: Available
  final List<String> _filters = ['All', 'Connected', 'Available'];

  late List<FitnessDevice> _devices;

  @override
  void initState() {
    super.initState();
    _devices = [
      FitnessDevice(
        id: 'EXP-9942-X',
        name: 'Universal Fitness Expander',
        category: 'Resistance Equipment',
        status: DeviceStatus.connected,
        level: widget.currentLevel,
        batteryLevel: 92,
        firmwareVersion: 'v2.4.1',
        lastSynced: 'Just now',
      ),
      FitnessDevice(
        id: 'BND-8821-P',
        name: 'Smart Resistance Band Pro',
        category: 'Wearable Tech',
        status: DeviceStatus.connected,
        level: 8,
        batteryLevel: 85,
        firmwareVersion: 'v1.8.0',
        lastSynced: '2 mins ago',
      ),
      FitnessDevice(
        id: 'DB-4412-M',
        name: 'Ergonomic Smart Dumbbell',
        category: 'Strength Training',
        status: DeviceStatus.disconnected,
        level: 10,
        batteryLevel: 40,
        firmwareVersion: 'v1.2.0',
        lastSynced: 'Yesterday',
      ),
      FitnessDevice(
        id: 'PLS-1029-S',
        name: 'Pulse Track Sensor',
        category: 'Heart Rate Monitor',
        status: DeviceStatus.connecting,
        level: 1,
        batteryLevel: 100,
        firmwareVersion: 'v3.0.2',
        lastSynced: 'Connecting...',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final filteredDevices = _devices.where((device) {
      if (_selectedFilterIndex == 1) return device.status == DeviceStatus.connected;
      if (_selectedFilterIndex == 2) return device.status == DeviceStatus.disconnected;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Devices',
                        style: GoogleFonts.outfit(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryText,
                          letterSpacing: -0.8,
                        ),
                      ),
                      Text(
                        'Manage connected equipment',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),

                  // Connect Device Button
                  GestureDetector(
                    onTap: _showConnectDeviceSheet,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.darkCard,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.add_rounded, color: Colors.white, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            'Pair Device',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Filter Segmented Control
              _buildFilterBar(),
              const SizedBox(height: 20),

              // Device Cards List
              Expanded(
                child: filteredDevices.isEmpty
                    ? _buildEmptyState()
                    : ListView.separated(
                        itemCount: filteredDevices.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          return _buildDeviceCard(filteredDevices[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.pillBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: List.generate(_filters.length, (index) {
          final isSelected = index == _selectedFilterIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilterIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.darkCard : Colors.transparent,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Center(
                  child: Text(
                    _filters[index],
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? Colors.white : AppColors.secondaryText,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDeviceCard(FitnessDevice device) {
    return GestureDetector(
      onTap: () {
        if (device.name == 'Universal Fitness Expander') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeviceDetailScreen(
                initialLevel: widget.currentLevel,
                onStartWorkout: widget.onStartWorkout,
              ),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Device Icon Container
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.pillBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _getDeviceIcon(device.category),
                color: AppColors.darkCard,
                size: 26,
              ),
            ),
            const SizedBox(width: 14),

            // Device Info Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    device.name,
                    style: GoogleFonts.outfit(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    device.category,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryText,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildStatusPill(device.status, device.batteryLevel),
                ],
              ),
            ),

            // Chevron Button
            const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.secondaryText, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusPill(DeviceStatus status, int battery) {
    switch (status) {
      case DeviceStatus.connected:
        return Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppColors.activeGreen,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'Connected • $battery% Battery',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.activeGreen,
              ),
            ),
          ],
        );
      case DeviceStatus.disconnected:
        return Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppColors.secondaryText,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'Disconnected',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.secondaryText,
              ),
            ),
          ],
        );
      case DeviceStatus.connecting:
        return Row(
          children: [
            const SizedBox(
              width: 10,
              height: 10,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.warningOrange),
            ),
            const SizedBox(width: 6),
            Text(
              'Connecting...',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.warningOrange,
              ),
            ),
          ],
        );
    }
  }

  IconData _getDeviceIcon(String category) {
    if (category.contains('Resistance')) return Icons.fitness_center_rounded;
    if (category.contains('Strength')) return Icons.sports_gymnastics_rounded;
    if (category.contains('Heart')) return Icons.favorite_rounded;
    return Icons.watch_rounded;
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bluetooth_searching_rounded, size: 56, color: AppColors.secondaryText.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            'No fitness devices connected',
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Turn on Bluetooth to pair your smart equipment.',
            style: GoogleFonts.inter(fontSize: 14, color: AppColors.secondaryText),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _showConnectDeviceSheet,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkCard,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text('Connect Device', style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showConnectDeviceSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pair New Equipment',
                    style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.mint,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2.5, color: AppColors.darkCard),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      'Searching for Bluetooth devices nearby...',
                      style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
