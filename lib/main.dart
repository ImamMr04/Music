import 'dart:ui'; 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MusicDashboardApp());
}

class MusicDashboardApp extends StatelessWidget {
  const MusicDashboardApp({Key? key}) : super(key: key);

  // --- Palet Warna ---
  static const Color darkPurple = Color(0xFF2E1A47);
  static const Color lightGreenAccent = Color(0xFFAEDC4E); 
  static const Color grayLightText = Color(0xFF999999);
  static const Color grayDark = Color(0xFF2B2B2B);
  static const Color graySlightlyLighter = Color(0xFFCCCCCC); 

  // Penambahan untuk Layering Dark Mode
  static const Color darkListBackground = Color(0xFF28183C); 
  static const Color listItemColor = Color(0xFF352055);     

  // Warna untuk efek cahaya/blob
  static const Color glowPurple = Color(0xFF8A2BE2); 
  static const Color glowPink = Color(0xFFEE82EE); 
  static const Color baseGradientStart = Color(0xFF200F36); 
  static const Color baseGradientEnd = Color(0xFF150B20); 
  
  // Gradien
  static const LinearGradient playButtonGradient = LinearGradient(
    colors: [Color(0xFFAEDC4E), Color(0xFFBBE578)], 
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.transparent, 
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
          ),
        ),
      ),
      home: const MusicDashboardPage(),
    );
  }
}

// =================================================================
// 1. MUSIC DASHBOARD PAGE (STATEFUL WIDGET UTAMA)
// =================================================================

class MusicDashboardPage extends StatefulWidget {
  const MusicDashboardPage({Key? key}) : super(key: key);

  @override
  State<MusicDashboardPage> createState() => _MusicDashboardPageState();
}

class _MusicDashboardPageState extends State<MusicDashboardPage> {
  int selectedCategoryIndex = 0;
  final ScrollController _scrollController = ScrollController(); 

  final List<Map<String, dynamic>> topDailyPlaylists = [
    {'title': 'Starlit Reverie', 'artist': 'Budiarti', 'songs': 8, 'image': 'assets/images/album1.jpg'},
    {'title': 'Midnight Confessions', 'artist': 'Nia', 'songs': 12, 'image': 'assets/images/album2.jpg'},
    {'title': 'Lost in the Echo', 'artist': 'Alex', 'songs': 10, 'image': 'assets/images/album3.jpg'},
    {'title': 'Acoustic Dreams', 'artist': 'Risa', 'songs': 15, 'image': 'assets/images/profile_woman.jpeg'},
    {'title': 'Epic Soundtracks', 'artist': 'Hans', 'songs': 20, 'image': 'assets/images/headphone_woman.jpeg'},
    {'title': 'Lo-Fi Focus', 'artist': 'Beats Master', 'songs': 7, 'image': 'assets/images/chill_vibes.jpg'},
    {'title': 'Deep House Mix', 'artist': 'DJ Kimi', 'songs': 18, 'image': 'assets/images/top_hits.jpg'},
    {'title': '80s Rewind', 'artist': 'Retro', 'songs': 25, 'image': 'assets/images/jazz_essentials.jpg'},
  ];

  final List<Map<String, String>> curatedCards = [
    {'title': 'Discover weekly', 'description': 'The original slow instrumental best playlists.', 'image': 'assets/images/headphone_woman.jpeg', 'color_hex': '#553488'},
    {'title': 'Chill Vibes', 'description': 'Soft beats to relax and focus.', 'image': 'assets/images/chill_vibes.jpg', 'color_hex': '#422744'},
    {'title': 'Top Hits 2024', 'description': 'Most popular tracks this year.', 'image': 'assets/images/top_hits.jpg', 'color_hex': '#304128'},
    {'title': 'Jazz Essentials', 'description': 'Classic and modern jazz mixes.', 'image': 'assets/images/jazz_essentials.jpg', 'color_hex': '#403B23'},
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  final double bottomBarHeight = 65; 
  final double miniPlayerHeight = 60; 
  final double bottomBarMargin = 10; 

  @override
  Widget build(BuildContext context) {
    final grayLightText = MusicDashboardApp.grayLightText;
    final statusColor = MusicDashboardApp.graySlightlyLighter; 
    final double totalBottomPadding =
        miniPlayerHeight + bottomBarHeight + (bottomBarMargin * 2) + 8; 

    return Scaffold(
      extendBody: true, 
      backgroundColor: Colors.transparent, 
      body: Stack(
        children: [
          // --- BACKGROUND DENGAN GRADIENT DAN BLOBS ---
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    MusicDashboardApp.baseGradientStart,
                    MusicDashboardApp.baseGradientEnd,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -100, left: -150, 
                    child: Container(
                      width: 300, height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [MusicDashboardApp.glowPurple.withOpacity(0.5), MusicDashboardApp.baseGradientStart.withOpacity(0),],
                          stops: const [0.0, 1.0],
                        ),
                        boxShadow: [BoxShadow(color: MusicDashboardApp.glowPurple.withOpacity(0.4), blurRadius: 120, spreadRadius: 40,),],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -120, right: -100,
                    child: Container(
                      width: 280, height: 280,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [MusicDashboardApp.glowPink.withOpacity(0.4), MusicDashboardApp.baseGradientEnd.withOpacity(0),],
                          stops: const [0.0, 1.0],
                        ),
                        boxShadow: [BoxShadow(color: MusicDashboardApp.glowPink.withOpacity(0.3), blurRadius: 100, spreadRadius: 30,),],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- KONTEN UTAMA (CUSTOM SCROLLVIEW) DENGAN EFEK BOUNCING ---
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              // Menonaktifkan Android/Web glow (hanya menyisakan efek pantulan)
              overscroll.disallowIndicator(); 
              return false;
            },
            child: CustomScrollView(
              controller: _scrollController, 
              // BouncingScrollPhysics memberikan efek elastis/pantulan seperti iOS
              physics: const BouncingScrollPhysics(),
              slivers: [
                /// STATUS BAR & PROFILE
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    child: Column(
                      children: [
                        // Status bar dummy
                        Row(
                          children: [
                            Text('9:41', style: GoogleFonts.poppins(color: statusColor, fontWeight: FontWeight.w600, fontSize: 18)),
                            const Spacer(),
                            Icon(Icons.signal_cellular_4_bar, color: statusColor, size: 20),
                            const SizedBox(width: 10),
                            Icon(Icons.battery_full, color: statusColor, size: 20),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Profile & Greeting
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start, 
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/images/profile_woman.jpeg'), backgroundColor: Colors.transparent),
                                const SizedBox(height: 5), 
                                Text('Hi, Samantha', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18), maxLines: 1, overflow: TextOverflow.ellipsis),
                              ],
                            ),
                            const Spacer(), 
                            CircularIconButton(icon: Icons.search, onTap: () {}),
                            const SizedBox(width: 10),
                            CircularIconButton(icon: Icons.favorite_border, onTap: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 10)),

                /// CATEGORY BUTTONS
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _categoryButton('All', 0),
                          _categoryButton('New Release', 1),
                          _categoryButton('Trending', 2),
                          _categoryButton('Top', 3),
                        ],
                      ),
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 15)),

                /// CURATED SECTION
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Curated & trending', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 170,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: curatedCards.length,
                        itemBuilder: (context, index) {
                          final card = curatedCards[index];
                          return CuratedTrendingCard(
                            title: card['title']!, description: card['description']!,
                            imagePath: card['image']!, bgColor: _getColorFromHex(card['color_hex']!),
                            isFirst: index == 0,
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // --- WRAPPER UNTUK BACKGROUND LIST PLAYLIST ---
                SliverToBoxAdapter(
                  child: Container(
                    color: MusicDashboardApp.darkListBackground, 
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          /// TOP DAILY PLAYLISTS TITLE
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Top daily playlists', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20)),
                              Text('See all', style: GoogleFonts.poppins(color: grayLightText, fontSize: 14, fontWeight: FontWeight.w500))
                            ],
                          ),
                          // Jarak setelah judul
                          const SizedBox(height: 5), 
                          /// LIST PLAYLISTS
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(), 
                            shrinkWrap: true,
                            itemCount: topDailyPlaylists.length,
                            itemBuilder: (context, index) {
                              final item = topDailyPlaylists[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                    // Jarak antar item
                                    bottom: index == topDailyPlaylists.length - 1 ? totalBottomPadding : 8), 
                                child: AnimatedPlaylistItem(
                                  index: index, 
                                  scrollController: _scrollController, 
                                  child: InteractivePlaylistItem( 
                                    onTap: () {
                                      print('Playlist ${item['title']} selected!');
                                    },
                                    child: Card(
                                      color: MusicDashboardApp.listItemColor, 
                                      elevation: 0,
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        // Padding internal item
                                        padding: const EdgeInsets.all(10.0), 
                                        child: PlaylistItem(
                                          imageUrl: item['image'],
                                          title: item['title'],
                                          artist: item['artist'],
                                          songCount: item['songs'],
                                          onPlayPressed: () {},
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomArea(),
    );
  }

  // CATEGORY WIDGET
  Widget _categoryButton(String label, int index) {
    final isSelected = selectedCategoryIndex == index;
    final targetColor = isSelected ? MusicDashboardApp.lightGreenAccent : MusicDashboardApp.grayDark;
    final targetTextColor = isSelected ? Colors.white : MusicDashboardApp.grayLightText;

    return GestureDetector(
      onTap: () {
        setState(() => selectedCategoryIndex = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
        decoration: BoxDecoration(
          color: targetColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: MusicDashboardApp.lightGreenAccent.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          style: GoogleFonts.poppins(color: targetTextColor, fontWeight: FontWeight.w600, fontSize: 14),
          child: Text(label),
        ),
      ),
    );
  }
}

// =================================================================
// 2. WIDGET INTERAKSI & ANIMASI
// =================================================================

class InteractivePlaylistItem extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const InteractivePlaylistItem({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  State<InteractivePlaylistItem> createState() => _InteractivePlaylistItemState();
}

class _InteractivePlaylistItemState extends State<InteractivePlaylistItem> {
  bool isTapped = false;
  bool isHovering = false; 

  bool get isActive => isTapped || isHovering;

  double get scale => isActive ? 1.02 : 1.0; 
  double get translateY => isActive ? -5.0 : 0.0; 

  @override
  Widget build(BuildContext context) {
    return MouseRegion( 
      onEnter: (event) => setState(() => isHovering = true),
      onExit: (event) => setState(() => isHovering = false),
      child: GestureDetector( 
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => isTapped = true),
        onTapUp: (_) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted) setState(() => isTapped = false);
          });
        },
        onTapCancel: () => setState(() => isTapped = false),

        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            transform: Matrix4.translationValues(0, translateY, 0),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class AnimatedPlaylistItem extends StatefulWidget {
  final Widget child;
  final int index;
  final ScrollController scrollController; 

  const AnimatedPlaylistItem({
    Key? key,
    required this.child,
    required this.index,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<AnimatedPlaylistItem> createState() => _AnimatedPlaylistItemState();
}

class _AnimatedPlaylistItemState extends State<AnimatedPlaylistItem>
    with SingleTickerProviderStateMixin {
  
  late AnimationController _initialSlideController; 
  late Animation<Offset> _initialSlideAnimation;
  
  double _parallaxOffset = 0.0; 
  final GlobalKey _key = GlobalKey(); 

  @override
  void initState() {
    super.initState();
    _initialSlideController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 600),
    );
    _initialSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), end: Offset.zero, 
    ).animate(CurvedAnimation(parent: _initialSlideController, curve: Curves.easeOut));

    Future.delayed(Duration(milliseconds: 50 * widget.index), () {
      if (mounted) _initialSlideController.forward();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.scrollController.addListener(_updateParallax);
        _updateParallax(); 
      }
    });
  }

  void _updateParallax() {
    if (_key.currentContext == null) return;

    final RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    
    final position = renderBox.localToGlobal(Offset.zero).dy;
    final viewportHeight = MediaQuery.of(context).size.height;
    final centerPosition = viewportHeight / 2;
    final distanceFromCenter = position - centerPosition;

    const parallaxFactor = 0.4; 
    
    final newOffset = distanceFromCenter * parallaxFactor;

    if (newOffset != _parallaxOffset && mounted) {
      setState(() {
        _parallaxOffset = newOffset;
      });
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_updateParallax);
    _initialSlideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _initialSlideController,
      builder: (context, child) {
        return SlideTransition(
          key: _key, 
          position: _initialSlideAnimation,
          child: FadeTransition( 
            opacity: _initialSlideController,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300), 
              curve: Curves.easeOut, 
              transform: Matrix4.translationValues(0, _parallaxOffset, 0), 
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}

// =================================================================
// 3. WIDGET KOMPONEN UI
// =================================================================

/// ICON BUTTON CIRCULAR
class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CircularIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MusicDashboardApp.grayDark,
      shape: const CircleBorder(),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 22, color: Colors.white),
        ),
      ),
    );
  }
}

/// CURATED TRENDING CARD
class CuratedTrendingCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final Color bgColor;
  final bool isFirst;

  const CuratedTrendingCard({
    Key? key,
    required this.title, required this.description,
    required this.imagePath, required this.bgColor,
    this.isFirst = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320, height: 170,
      margin: EdgeInsets.only(right: 10),
      padding: const EdgeInsets.fromLTRB(15, 15, 10, 15),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Positioned(
            top: 0, left: 0, right: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 5),
                Text(description, style: GoogleFonts.poppins(fontSize: 13, color: Colors.white70, fontWeight: FontWeight.w500), maxLines: 2, overflow: TextOverflow.ellipsis)
              ],
            ),
          ),
          Positioned(
            bottom: 0, left: 0,
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white24),
                  child: IconButton(icon: const Icon(Icons.play_arrow, color: Colors.white, size: 28), onPressed: () {}, splashRadius: 20),
                ),
                const SizedBox(width: 8),
                IconButton(icon: const Icon(Icons.favorite_border, color: Colors.white70, size: 20), onPressed: () {}, splashRadius: 20),
                const SizedBox(width: 8),
                IconButton(icon: const Icon(Icons.more_horiz, color: Colors.white70, size: 20), onPressed: () {}, splashRadius: 20),
              ],
            ),
          ),
          Positioned(
            right: 0, top: 0, bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(imagePath, width: 110, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}

/// PLAYLIST ITEM (UI item baris)
class PlaylistItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String artist;
  final int songCount;
  final VoidCallback onPlayPressed;

  const PlaylistItem({
    Key? key,
    required this.imageUrl, required this.title,
    required this.artist, required this.songCount,
    required this.onPlayPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final grayLightText = MusicDashboardApp.grayLightText;
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0), 
          child: Image.asset(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 5),
              Text('By $artist • $songCount Songs', style: GoogleFonts.poppins(color: grayLightText, fontSize: 13, fontWeight: FontWeight.w500))
            ],
          ),
        ),
        
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return MusicDashboardApp.playButtonGradient.createShader(bounds);
          },
          child: IconButton(
            icon: const Icon(Icons.play_circle_fill, color: Colors.white), 
            iconSize: 32, 
            onPressed: onPlayPressed, 
            splashRadius: 25,
          ),
        ),
      ],
    );
  }
}

// BOTTOM NAVIGATION BAR DAN MINI PLAYER (GLASSCARD)
class BottomArea extends StatelessWidget {
  const BottomArea({Key? key}) : super(key: key);

  final double navbarHeight = 65;
  final double miniPlayerHeight = 60;
  final double bottomMargin = 10; 
  final double spacing = 8; 

  Widget _buildGlassCard({
    required Widget child, required double width,
    required double height, required double borderRadius,
    Color blurColor = const Color(0xFFFFFFFF), double blurAmount = 10.0,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: Container(
          width: width, height: height,
          decoration: BoxDecoration(
            color: blurColor.withOpacity(0.1), 
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: -5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = MusicDashboardApp.lightGreenAccent;
    final screenWidth = MediaQuery.of(context).size.width * 0.85;

    return Container( 
      color: Colors.transparent, 
      height: navbarHeight + miniPlayerHeight + (bottomMargin * 2) + spacing, 
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          /// MINI PLAYER (FLOATING - GLASSCARD)
          Positioned(
            bottom: navbarHeight + bottomMargin + spacing, 
            child: Column( 
              children: [
                // Progress Bar (Dummy)
                Container(
                  width: screenWidth, 
                  height: 3, 
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.7, // Dummy progress 70%
                    child: Container(
                      height: 3,
                      decoration: BoxDecoration(
                        gradient: MusicDashboardApp.playButtonGradient, 
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5), 
                _buildGlassCard(
                  width: screenWidth, height: miniPlayerHeight, borderRadius: 20, blurAmount: 10.0, 
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Lost in the Echo', style: GoogleFonts.poppins(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)
                        ),
                        // Tombol pause/play dengan Gradient
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return MusicDashboardApp.playButtonGradient.createShader(bounds);
                          },
                          child: const Icon(Icons.pause_circle_filled, color: Colors.white),
                          // Ganti icon ini dengan Icon(Icons.play_circle_fill, color: Colors.white) jika lagu sedang pause
                          // Jika Anda ingin icon yang lebih besar, atur size di sini
                          // child: Icon(Icons.pause_circle_fill, color: Colors.white, size: 30),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.skip_next, color: Colors.white, size: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// FLOATING NAVBAR (GLASSCARD)
          Positioned(
            bottom: bottomMargin, 
            child: _buildGlassCard(
              width: screenWidth, height: navbarHeight, borderRadius: 30, blurAmount: 10.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomIconButton(icon: Icons.home, isActive: true, activeColor: activeColor, onTap: () {}),
                  BottomIconButton(icon: Icons.search, isActive: false, onTap: () {}),
                  BottomIconButton(icon: Icons.library_music_outlined, isActive: false, onTap: () {}),
                  BottomIconButton(icon: Icons.person_outline, isActive: false, onTap: () {}),
                   BottomIconButton(icon: Icons.settings, isActive: false, onTap: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class BottomIconButton extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final Color activeColor;

  const BottomIconButton({
    Key? key, required this.icon, required this.onTap,
    this.activeColor = Colors.white, this.isActive = false, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double scale = isActive ? 1.15 : 1.0; 

    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: scale, 
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Container( 
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), 
          decoration: isActive
              ? BoxDecoration(
                  color: activeColor.withOpacity(0.2), 
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: activeColor.withOpacity(0.5), width: 1.5), 
                )
              : null, 
          child: Icon(icon, color: isActive ? activeColor : Colors.white70, size: 28),
        ),
      ),
    );
  }
}