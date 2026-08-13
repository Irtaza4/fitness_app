import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/app_header.dart';
import 'device_detail_screen.dart';

class HeroDeviceItem {
  final String title;
  final String metricValue;
  final String metricLabel;
  final String badgeText;
  final Color stackedLayerColor;
  final String imageUrl;

  HeroDeviceItem({
    required this.title,
    required this.metricValue,
    required this.metricLabel,
    required this.badgeText,
    required this.stackedLayerColor,
    required this.imageUrl,
  });
}

class HomeScreen extends StatefulWidget {
  final Function(int) onNavigateTab;
  final Function(int) onStartWorkout;
  final int currentLevel;
  final bool isDarkMode;

  const HomeScreen({
    Key? key,
    required this.onNavigateTab,
    required this.onStartWorkout,
    this.currentLevel = 12,
    this.isDarkMode = false,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedCategoryIndex = 0; // 0: Connection, 1: Statistics, 2: Shop
  final List<String> _categories = ['Connection', 'Statistics', 'Shop'];

  int _activeCardIndex = 0;
  double _dragOffsetY = 0.0;
  bool _isTransitioning = false;
  int _transitionDirection = 1; // 1 for next, -1 for prev

  late AnimationController _snapController;
  late Animation<double> _snapAnimation;

  late List<HeroDeviceItem> _heroDevices;

  @override
  void initState() {
    super.initState();

    _snapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _snapAnimation = CurvedAnimation(
      parent: _snapController,
      curve: Curves.fastOutSlowIn,
    );

    _snapController.addListener(() {
      if (mounted) setState(() {});
    });

    _heroDevices = [
      HeroDeviceItem(
        title: 'Universal\nFitness\nExpander',
        metricValue: '${widget.currentLevel}',
        metricLabel: '+',
        badgeText: 'PROGRAMS',
        stackedLayerColor: AppColors.lavender,
        imageUrl: 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=400&auto=format&fit=crop&q=80',
      ),
      HeroDeviceItem(
        title: 'Ergonomic\nSmart\nDumbbell',
        metricValue: '10.5',
        metricLabel: 'KG',
        badgeText: 'STRENGTH',
        stackedLayerColor: AppColors.mint,
        imageUrl: 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?w=400&auto=format&fit=crop&q=80',
      ),
      HeroDeviceItem(
        title: 'Pulse Track\nSensor\nBand',
        metricValue: '74',
        metricLabel: 'BPM',
        badgeText: 'CARDIOMONITOR',
        stackedLayerColor: AppColors.softYellow,
        imageUrl: 'https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6?w=400&auto=format&fit=crop&q=80',
      ),
      HeroDeviceItem(
        title: 'Smart\nResistance\nBand Pro',
        metricValue: '8',
        metricLabel: 'LVL',
        badgeText: 'TENSION',
        stackedLayerColor: const Color(0xFFD6C8F4),
        imageUrl: 'https://images.unsplash.com/photo-1598289431512-b97b0917affc?w=400&auto=format&fit=crop&q=80',
      ),
    ];
  }

  @override
  void dispose() {
    _snapController.dispose();
    super.dispose();
  }

  void _triggerSwoopToNext() {
    setState(() {
      _isTransitioning = true;
      _transitionDirection = 1;
    });

    _snapController.forward(from: 0.0).then((_) {
      setState(() {
        _activeCardIndex = (_activeCardIndex + 1) % _heroDevices.length;
        _dragOffsetY = 0.0;
        _isTransitioning = false;
        _snapController.reset();
      });
    });
  }

  void _triggerSwoopToPrevious() {
    setState(() {
      _isTransitioning = true;
      _transitionDirection = -1;
    });

    _snapController.forward(from: 0.0).then((_) {
      setState(() {
        _activeCardIndex = (_activeCardIndex - 1 + _heroDevices.length) % _heroDevices.length;
        _dragOffsetY = 0.0;
        _isTransitioning = false;
        _snapController.reset();
      });
    });
  }

  void _snapBackToFront() {
    _snapController.reverse(from: 1.0).then((_) {
      setState(() {
        _dragOffsetY = 0.0;
        _snapController.reset();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;
    final primaryTextColor = isDark ? Colors.white : AppColors.primaryText;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0E0E10) : AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top App Header
                    AppHeader(
                      showBackButton: false,
                      onCalendar: () {},
                      onProfile: () => widget.onNavigateTab(3),
                    ),
                    const SizedBox(height: 12),

                    // Page Title
                    Text(
                      'Fitness\nTracking Device',
                      style: GoogleFonts.outfit(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: primaryTextColor,
                        height: 1.1,
                        letterSpacing: -0.8,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Category Segmented Control
                    _buildCategoryPillSelector(isDark),
                    const SizedBox(height: 20),

                    // Ultra-Tactile Two-Phase Card Drag & Swoop-In Deck Engine
                    Expanded(
                      child: _buildTwoPhasePhysicalDragEngine(context, isDark),
                    ),
                  ],
                ),
              ),
            ),

            // Floating Bottom Navigation Capsule Bar
            _buildFloatingBottomBar(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryPillSelector(bool isDark) {
    return Row(
      children: List.generate(_categories.length, (index) {
        final isSelected = index == _selectedCategoryIndex;
        final selectedColor = isDark ? AppColors.mint : AppColors.darkCard;
        final unselectedColor = isDark ? const Color(0xFF1B1B1E) : Colors.white;
        final textColor = isSelected
            ? (isDark ? AppColors.darkCard : Colors.white)
            : (isDark ? Colors.white.withValues(alpha: 0.7) : AppColors.primaryText);

        return Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () {
              setState(() => _selectedCategoryIndex = index);
              if (index == 1) widget.onNavigateTab(1); // Statistics
              if (index == 2) widget.onNavigateTab(2); // Devices
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
              decoration: BoxDecoration(
                color: isSelected ? selectedColor : unselectedColor,
                borderRadius: BorderRadius.circular(24),
                border: isDark && !isSelected
                    ? Border.all(color: Colors.white.withValues(alpha: 0.1))
                    : null,
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: (isDark ? AppColors.mint : Colors.black).withValues(alpha: 0.15),
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
                  color: textColor,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  /// Two-Phase Physical Drag & Swoop-In Deck Engine
  Widget _buildTwoPhasePhysicalDragEngine(BuildContext context, bool isDark) {
    final totalCards = _heroDevices.length;
    final animValue = _snapAnimation.value;

    // Active drag progress (0.0 to 1.0)
    double dragProgress = 0.0;
    if (_isTransitioning) {
      dragProgress = animValue;
    } else if (_dragOffsetY != 0.0) {
      dragProgress = (_dragOffsetY.abs() / 150.0).clamp(0.0, 1.0);
    }

    // RENDER ORDER IN STACK:
    // WHILE DRAGGING: Card 0 is ON TOP [3, 2, 1, 0] so it stays under your finger!
    // UPON SWOOP TRANSITION (after drag release): Card 0 swoops under Card 1 -> [0, 3, 2, 1]!
    List<int> stackRenderOrder;
    if (_isTransitioning) {
      stackRenderOrder = [0, 3, 2, 1]; // Swooping behind phase
    } else {
      stackRenderOrder = [3, 2, 1, 0]; // Finger holding phase (Card 0 on top!)
    }

    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              if (!_isTransitioning) {
                setState(() {
                  _dragOffsetY += details.delta.dy;
                });
              }
            },
            onVerticalDragEnd: (details) {
              if (!_isTransitioning) {
                if (_dragOffsetY > 45 || details.primaryVelocity! > 200) {
                  _triggerSwoopToNext();
                } else if (_dragOffsetY < -45 || details.primaryVelocity! < -200) {
                  _triggerSwoopToPrevious();
                } else {
                  _snapBackToFront();
                }
              }
            },
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: stackRenderOrder.map((depthIndex) {
                final deviceIndex = (_activeCardIndex + depthIndex) % totalCards;
                final item = _heroDevices[deviceIndex];

                final isHeldCard = depthIndex == 0;
                final depthFactor = depthIndex.toDouble();

                // Base Geometry for cards in resting stack
                double translateY = depthFactor * 18.0;
                double scale = 1.0 - (depthFactor * 0.06);
                double opacity = (1.0 - (depthFactor * 0.15)).clamp(0.4, 1.0);
                double rotationX = 0.0;

                if (!_isTransitioning) {
                  // ================= PHASE 1: FINGER DRAGGING =================
                  if (isHeldCard) {
                    // Card 0: Stays ON TOP directly under user's finger!
                    translateY = _dragOffsetY;
                    rotationX = (_dragOffsetY * 0.0014).clamp(-0.35, 0.35);
                    scale = 1.0 - (dragProgress * 0.04);
                  } else {
                    // Cards 1, 2, 3: Deck behind dynamically OPENS UP SPACE as you drag!
                    // Gap opens from 18px to 32px per card!
                    final slotGapExpansion = dragProgress * 14.0;
                    translateY = (depthFactor * 18.0) - slotGapExpansion;
                    scale = (1.0 - (depthFactor * 0.06)) + (dragProgress * 0.03);
                  }
                } else {
                  // ================= PHASE 2: SWOOP INTO BACK SLOT =================
                  if (isHeldCard) {
                    // Held Card swoops down & tucks into the open slot at back of stack
                    final initialDrag = _dragOffsetY;
                    translateY = initialDrag + (animValue * (54.0 - initialDrag));
                    rotationX = ((1.0 - animValue) * (initialDrag * 0.0014)).clamp(-0.4, 0.4);
                    scale = 1.0 - (animValue * 0.18); // Shrinks to back slot size 0.82
                    opacity = (1.0 - (animValue * 0.4)).clamp(0.4, 1.0);
                  } else if (depthIndex == 1) {
                    // Next Card physically swells FORWARD into hero position!
                    translateY = (1.0 - animValue) * 18.0;
                    scale = 0.94 + (animValue * 0.06);
                    opacity = 0.85 + (animValue * 0.15);
                  } else if (depthIndex == 2) {
                    translateY = (2.0 - animValue) * 18.0;
                    scale = 0.88 + (animValue * 0.06);
                  } else if (depthIndex == 3) {
                    translateY = (3.0 - animValue) * 18.0;
                    scale = 0.82 + (animValue * 0.06);
                  }
                }

                return Positioned(
                  top: translateY,
                  left: 0,
                  right: 0,
                  child: Transform(
                    alignment: Alignment.topCenter,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.0015)
                      ..rotateX(rotationX)
                      ..scale(scale, scale),
                    child: Opacity(
                      opacity: opacity,
                      child: GestureDetector(
                        onTap: () {
                          if (depthIndex == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DeviceDetailScreen(
                                  initialLevel: widget.currentLevel,
                                  onStartWorkout: widget.onStartWorkout,
                                ),
                              ),
                            );
                          } else {
                            setState(() {
                              _activeCardIndex = deviceIndex;
                              _dragOffsetY = 0.0;
                            });
                          }
                        },
                        child: _buildSingleDeckCard(
                          context,
                          item,
                          isDark,
                          isFrontCard: depthIndex == (_isTransitioning ? 1 : 0),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Pagination Dots Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(totalCards, (index) {
            final isSelected = index == _activeCardIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: isSelected ? 8 : 5,
              height: isSelected ? 8 : 5,
              decoration: BoxDecoration(
                color: isSelected
                    ? (isDark ? AppColors.mint : AppColors.darkCard)
                    : (isDark ? Colors.white30 : AppColors.secondaryText.withValues(alpha: 0.3)),
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _buildSingleDeckCard(BuildContext context, HeroDeviceItem item, bool isDark, {bool isFrontCard = false}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background Layered Sheet Top Edge Peeking Out
        Positioned(
          top: -12,
          left: 18,
          right: 18,
          child: Container(
            height: 38,
            decoration: BoxDecoration(
              color: item.stackedLayerColor,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),

        // Main Dark Content Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(28.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isFrontCard ? 0.38 : 0.2),
                blurRadius: isFrontCard ? 30 : 16,
                offset: Offset(0, isFrontCard ? 14 : 6),
              ),
            ],
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 84,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Header Row inside Card
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.15,
                        ),
                      ),
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
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.qr_code_2_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Main Content Row (Metric + Product Photo Box)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.metricLabel,
                            style: GoogleFonts.outfit(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withValues(alpha: 0.7),
                              height: 1.0,
                            ),
                          ),
                          Text(
                            item.metricValue,
                            style: GoogleFonts.outfit(
                              fontSize: 48,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 0.95,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              item.badgeText,
                              style: GoogleFonts.inter(
                                fontSize: 8,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Product Photo
                      Container(
                        width: 105,
                        height: 105,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            item.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: item.stackedLayerColor,
                              child: const Center(
                                child: Icon(Icons.fitness_center_rounded, color: AppColors.darkCard, size: 36),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingBottomBar(BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1B1B1E) : AppColors.darkCard,
        borderRadius: BorderRadius.circular(30),
        border: isDark ? Border.all(color: Colors.white.withValues(alpha: 0.12)) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => widget.onNavigateTab(2),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: isDark ? AppColors.mint : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.sports_rounded, color: AppColors.darkCard, size: 18),
            ),
          ),
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
          GestureDetector(
            onTap: () => widget.onNavigateTab(1),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.tune_rounded, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
