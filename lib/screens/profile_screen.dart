import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool>? onToggleDarkMode;

  const ProfileScreen({
    Key? key,
    this.isDarkMode = false,
    this.onToggleDarkMode,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;
  String _selectedUnit = 'Metric (kg, cm)';

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final bgColor = isDark ? const Color(0xFF0E0E10) : AppColors.background;
    final primaryTextColor = isDark ? Colors.white : AppColors.primaryText;
    final secondaryTextColor = isDark ? Colors.white.withValues(alpha: 0.6) : AppColors.secondaryText;
    final cardBgColor = isDark ? const Color(0xFF1B1B1E) : Colors.white;
    final cardBorderColor = isDark ? Colors.white.withValues(alpha: 0.1) : AppColors.border;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Profile',
                style: GoogleFonts.outfit(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: primaryTextColor,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 20),

              // Profile Header Hero Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Avatar Circle
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
                      ),
                      child: Center(
                        child: Text(
                          'AR',
                          style: GoogleFonts.outfit(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // User Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alex Rivers',
                            style: GoogleFonts.outfit(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.mint.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Advanced Athlete',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mint,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Edit Profile Button
                    GestureDetector(
                      onTap: _showEditProfileSheet,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit_rounded, color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Personal Statistics Section
              Text(
                'Personal Metrics',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: primaryTextColor,
                ),
              ),
              const SizedBox(height: 14),

              // 2x2 Personal Metrics Grid
              Row(
                children: [
                  Expanded(
                    child: _buildPersonalMetricCard(
                      label: 'Weight',
                      value: '72 kg',
                      cardBgColor: cardBgColor,
                      borderColor: cardBorderColor,
                      textColor: primaryTextColor,
                      subtextColor: secondaryTextColor,
                      onTap: () => _showMetricEditDialog('Weight', '72 kg'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildPersonalMetricCard(
                      label: 'Height',
                      value: '180 cm',
                      cardBgColor: cardBgColor,
                      borderColor: cardBorderColor,
                      textColor: primaryTextColor,
                      subtextColor: secondaryTextColor,
                      onTap: () => _showMetricEditDialog('Height', '180 cm'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildPersonalMetricCard(
                      label: 'Age',
                      value: '28 yrs',
                      cardBgColor: cardBgColor,
                      borderColor: cardBorderColor,
                      textColor: primaryTextColor,
                      subtextColor: secondaryTextColor,
                      onTap: () => _showMetricEditDialog('Age', '28 yrs'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildPersonalMetricCard(
                      label: 'Daily Goal',
                      value: '10,000 steps',
                      cardBgColor: isDark ? const Color(0xFF2A271B) : AppColors.softYellow,
                      borderColor: isDark ? AppColors.softYellow.withValues(alpha: 0.3) : Colors.transparent,
                      textColor: isDark ? AppColors.softYellow : AppColors.primaryText,
                      subtextColor: isDark ? AppColors.softYellow.withValues(alpha: 0.7) : AppColors.secondaryText,
                      onTap: () => _showMetricEditDialog('Daily Goal', '10,000 steps'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Settings Section
              Text(
                'Settings',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: primaryTextColor,
                ),
              ),
              const SizedBox(height: 14),

              Container(
                decoration: BoxDecoration(
                  color: cardBgColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: cardBorderColor),
                ),
                child: Column(
                  children: [
                    // Notifications Switch
                    ListTile(
                      leading: Icon(Icons.notifications_rounded, color: isDark ? AppColors.mint : AppColors.darkCard, size: 22),
                      title: Text(
                        'Notifications',
                        style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: primaryTextColor),
                      ),
                      trailing: Switch(
                        value: _notificationsEnabled,
                        activeThumbColor: isDark ? AppColors.mint : AppColors.darkCard,
                        onChanged: (val) {
                          setState(() => _notificationsEnabled = val);
                        },
                      ),
                    ),
                    Divider(height: 1, color: cardBorderColor),

                    // Connected Devices
                    _buildSettingsTile(
                      icon: Icons.bluetooth_rounded,
                      title: 'Connected Devices',
                      textColor: primaryTextColor,
                      isDark: isDark,
                      onTap: _showConnectedDevicesDialog,
                    ),
                    Divider(height: 1, color: cardBorderColor),

                    // Units & Measurements
                    _buildSettingsTile(
                      icon: Icons.straighten_rounded,
                      title: 'Units & Measurements',
                      subtitle: _selectedUnit,
                      textColor: primaryTextColor,
                      subtextColor: secondaryTextColor,
                      isDark: isDark,
                      onTap: _showUnitsPickerSheet,
                    ),
                    Divider(height: 1, color: cardBorderColor),

                    // Privacy & Security
                    _buildSettingsTile(
                      icon: Icons.lock_rounded,
                      title: 'Privacy & Security',
                      textColor: primaryTextColor,
                      isDark: isDark,
                      onTap: _showPrivacyDialog,
                    ),
                    Divider(height: 1, color: cardBorderColor),

                    // Dark Appearance Toggle Switch (UTILIZING DARK MODE TOGGLE!)
                    ListTile(
                      leading: Icon(Icons.palette_rounded, color: isDark ? AppColors.mint : AppColors.darkCard, size: 22),
                      title: Text(
                        'Dark Appearance',
                        style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: primaryTextColor),
                      ),
                      subtitle: Text(
                        isDark ? 'Dark theme active' : 'Light theme active',
                        style: GoogleFonts.inter(fontSize: 12, color: secondaryTextColor),
                      ),
                      trailing: Switch(
                        value: widget.isDarkMode,
                        activeThumbColor: AppColors.mint,
                        onChanged: (val) {
                          widget.onToggleDarkMode?.call(val);
                        },
                      ),
                    ),
                    Divider(height: 1, color: cardBorderColor),

                    // Help & Support
                    _buildSettingsTile(
                      icon: Icons.help_outline_rounded,
                      title: 'Help & Support',
                      textColor: primaryTextColor,
                      isDark: isDark,
                      onTap: _showHelpSupportSheet,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalMetricCard({
    required String label,
    required String value,
    required Color cardBgColor,
    required Color borderColor,
    required Color textColor,
    required Color subtextColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: subtextColor,
                  ),
                ),
                Icon(Icons.edit_outlined, size: 12, color: subtextColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required Color textColor,
    Color? subtextColor,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: isDark ? AppColors.mint : AppColors.darkCard, size: 22),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: subtextColor ?? AppColors.secondaryText))
          : null,
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: subtextColor ?? AppColors.secondaryText, size: 14),
      onTap: onTap,
    );
  }

  void _showEditProfileSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Edit Profile', style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Full Name', hintText: 'Alex Rivers')),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'Athlete Bio', hintText: 'Advanced Fitness Tracker')),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkCard),
                onPressed: () => Navigator.pop(context),
                child: const Text('Save Changes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMetricEditDialog(String label, String currentValue) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update $label', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        content: TextField(
          controller: TextEditingController(text: currentValue),
          decoration: InputDecoration(labelText: 'New $label'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkCard),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$label updated successfully!')));
            },
            child: const Text('Update', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showConnectedDevicesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Connected Devices', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            ListTile(leading: Icon(Icons.check_circle, color: AppColors.activeGreen), title: Text('Universal Fitness Expander')),
            ListTile(leading: Icon(Icons.check_circle, color: AppColors.activeGreen), title: Text('Smart Resistance Band Pro')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }

  void _showUnitsPickerSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Metric (kg, cm, km)'),
            onTap: () {
              setState(() => _selectedUnit = 'Metric (kg, cm)');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Imperial (lbs, ft/in, miles)'),
            onTap: () {
              setState(() => _selectedUnit = 'Imperial (lbs, miles)');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Privacy & Security', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        content: const Text('Your fitness data is encrypted end-to-end and stored locally on your device.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  void _showHelpSupportSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Help & Support', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const ListTile(leading: Icon(Icons.email_outlined), title: Text('Contact Support Team')),
            const ListTile(leading: Icon(Icons.question_answer_outlined), title: Text('Frequently Asked Questions')),
          ],
        ),
      ),
    );
  }
}
