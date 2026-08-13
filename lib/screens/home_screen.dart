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

  const HomeScreen({
    Key? key,
    required this.onNavigateTab,
    required this.onStartWorkout,
    this.currentLevel = 12,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedCategoryIndex = 0; // 0: Connection, 1: Statistics, 2: Shop
  final List<String> _categories = ['Connection', 'Statistics', 'Shop'];

  int _activeCardIndex = 0;
  double _dragOffsetY = 0.0;

  late List<HeroDeviceItem> _heroDevices;

  @override
  void initState() {
    super.initState();
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

  void _cycleNextCard() {
    setState(() {
      _activeCardIndex = (_activeCardIndex + 1) % _heroDevices.length;
      _dragOffsetY = 0.0;
    });
  }

  void _cyclePreviousCard() {
    setState(() {
      _activeCardIndex = (_activeCardIndex - 1 + _heroDevices.length) % _heroDevices.length;
      _dragOffsetY = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
                        color: AppColors.primaryText,
                        height: 1.1,
                        letterSpacing: -0.8,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Category Segmented Control
                    _buildCategoryPillSelector(),
                    const SizedBox(height: 20),

                    // Interactive 3D Folding Card Stack Deck
                    Expanded(
                      child: _build3DFoldingCardStackDeck(context),
                    ),
                  ],
                ),
              ),
            ),

            // Floating Bottom Navigation Capsule Bar
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
              if (index == 2) widget.onNavigateTab(2); // Devices
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
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

  /// 3D Folding Card Deck Stack Widget
  Widget _build3DFoldingCardStackDeck(BuildContext context) {
    final totalCards = _heroDevices.length;

    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              setState(() {
                _dragOffsetY += details.delta.dy;
              });
            },
            onVerticalDragEnd: (details) {
              if (_dragOffsetY > 60 || details.primaryVelocity! > 250) {
                _cycleNextCard();
              } else if (_dragOffsetY < -60 || details.primaryVelocity! < -250) {
                _cyclePreviousCard();
              } else {
                setState(() => _dragOffsetY = 0.0);
              }
            },
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: List.generate(totalCards, (stackPosition) {
                // Calculate item index from back to front
                // stackPosition 0 is bottom/back, stackPosition 3 is top/front card
                final reverseIndex = (totalCards - 1) - stackPosition;
                final deviceIndex = (_activeCardIndex + reverseIndex) % totalCards;
                final item = _heroDevices[deviceIndex];

                // Card stacking geometry parameters
                final isTopCard = reverseIndex == 0;
                final depthFactor = reverseIndex.toDouble(); // 0 = front, 1, 2, 3 = back cards

                // Vertical offset (back cards peek out above front card)
                double topOffset = (depthFactor * 16.0);
                double scale = 1.0 - (depthFactor * 0.06);
                double opacity = (1.0 - (depthFactor * 0.15)).clamp(0.4, 1.0);

                // Apply 3D Folding transformation on active drag
                double rotationX = 0.0;
                double translateY = topOffset;

                if (isTopCard) {
                  translateY += _dragOffsetY;
                  rotationX = (_dragOffsetY * 0.0015).clamp(-0.4, 0.4);
                }

                return Positioned(
                  top: translateY,
                  left: 0,
                  right: 0,
                  child: AnimatedContainer(
                    duration: _dragOffsetY == 0.0 ? const Duration(milliseconds: 300) : Duration.zero,
                    curve: Curves.easeOutCubic,
                    child: Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.0012)
                        ..rotateX(rotationX)
                        ..scaleByDouble(scale, scale, 1.0, 1.0),
                      child: Opacity(
                        opacity: opacity,
                        child: GestureDetector(
                          onTap: () {
                            if (isTopCard) {
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
                          child: _buildSingleDeckCard(context, item),
                        ),
                      ),
                    ),
                  ),
                );
              }),
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
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: isSelected ? 8 : 5,
              height: isSelected ? 8 : 5,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.darkCard : AppColors.secondaryText.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _buildSingleDeckCard(BuildContext context, HeroDeviceItem item) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background Layered Sheet Top Edge Peeking Out (Card Folding Deck visual)
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
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 24,
                offset: const Offset(0, 10),
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

  Widget _buildFloatingBottomBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(30),
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
          GestureDetector(
            onTap: () => widget.onNavigateTab(2),
            child: Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.sports_rounded, color: AppColors.darkCard, size: 18),
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
