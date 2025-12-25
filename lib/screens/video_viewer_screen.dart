import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoViewerScreen extends StatelessWidget {
  final String title;
  const VideoViewerScreen({super.key, required this.title});

  static const Color primaryColor = Color(0xFFBF4B49);
  static const Color youtubeRed = Color(0xFFFF0000);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF121212) : Colors.white;
    final listBgColor = isDark ? const Color(0xFF171717) : const Color(0xFFF9FAFB);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVideoPlayerMockup(isDark),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Text(
              'Video Lain Nya',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildVideoListItem(
                  thumbnailUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDqKgOIJFud6WRyFXOR1QZ_ZG4sopnqIMjxJc41kZLeHg0JKEFcoZ-ufqyDyP5enyED5pzoyWTBHFXwW0dQSKSRtLuKr-lnMvpczzJxxBFzTs-RQTby3CCRqUYLos5csPUVT9wdIM2hLyco-tT84rX81It4frpJEjqTTbNLA3-tXxCGdIvTIeYv7bmsyGsilq2rTNuJ9Xu_-Y10hgCjwGy-m47vO-QyFYDwKTycOiOmwF9gxEDOu_aztI4GtyufXZYBn0HsarpNJGI2',
                  title: 'Interaction Design',
                  isDark: isDark,
                  showPlayBadge: true,
                  isEven: true,
                ),
                _buildVideoListItem(
                  thumbnailUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBN9Z-UJunn937i-ACdDq5Mg73OuiWrK8HTquLv2i7CF7siNr-iwDoOgdyZ8yF0OmfhOmvsq4E7hXm1s-XuaPopLNbW3WBITlvTmRzOfQ6aRkpfVTMAZy4oOg_gu-RK_hnHFXyKG9Zm5x6-T4BXIkSnsBvIKryhLAiJg_UTeJqEwxzB4vvya06scT2L6m1DjyFdLAsPEwHAHL8KH-YpENUAf6hO5CsIsljHN5ilGg0wfUFRtpqff128GX28f3kk4I-m_1NxHkV5zvDu',
                  title: 'Pengantar Desain Antarmuka Pengguna',
                  isDark: isDark,
                  showUBadge: true,
                  showProgressBar: true,
                  isEven: false,
                ),
                _buildVideoListItem(
                  thumbnailUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBGYvsr8s2YbFfrAtiTODmhTd3wBwBz6lNtH2741SCBm7zLpeIOt9JYEKwXE6AU9Azw510N0I_WtRSqT_ztbWTeHoNUDVQxPLah3spj9yI-sDHePlluv-e6Y5Ovuvvk-UCSs9XqzF4jVhH0_24U6iZ_aMepvPnqmX-NNOGI0DdrP5U_28FVSQgd3nhuKBP0if8P2tw_qkuu-fR4EP0MfnEv4A1Rl3mClkhLiLC4PpZV5YAVckFDnujtPrlm_lcPTcMSMECZYRLVPZGv',
                  title: '4 Teori Dasar Desain Antarmuka Pengguna',
                  isDark: isDark,
                  showUBadge: true,
                  showProgressBar: true,
                  isEven: true,
                ),
                _buildFigmaVideoListItem(isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayerMockup(bool isDark) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          // Thumbnail
          Positioned.fill(
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDx2L0E4URARdoR9SnMjv5AfJLeymwOPRr66IVfexDhZH2bLAvXizY2WKc0xGIWK6OpDvEoGBhRQe3OfpuyNZKQPLr9elrUSGiBDZH1wUkVJU_PilbXJYXrWB9MWsogY5yexxBEM0_6vquVh_YS_d3JABp_FZTaMlH1HLy-Rn3BSUkml-gQR7Md_dgBlqPDMjwJWf09SPOWywwJ7imy1ytgnkKwro-4VZ31uB9vw1FmuoLB61AiU3UCjCmUg0hpd-hxbno8UHNL5tZR',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.2),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          // Center Text Overlay
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              color: Colors.black,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'UI',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                      height: 1,
                    ),
                  ),
                  Text(
                    'DESIGN',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 10,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Play Button overlay
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 140),
              width: 48,
              height: 32,
              decoration: BoxDecoration(
                color: youtubeRed,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.play_arrow, color: Colors.white, size: 20),
            ),
          ),
          // Controls bottom bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.play_arrow, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(1.5),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.65,
                          child: Container(
                            height: 3,
                            decoration: BoxDecoration(
                              color: youtubeRed,
                              borderRadius: BorderRadius.circular(1.5),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0.3, 0), // Approx 65%
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '15:04',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.settings, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  const Icon(Icons.fullscreen, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoListItem({
    required String thumbnailUrl,
    required String title,
    required bool isDark,
    bool showPlayBadge = false,
    bool showUBadge = false,
    bool showProgressBar = false,
    required bool isEven,
  }) {
    final bgColor = isEven 
        ? (isDark ? const Color(0xFF1E293B).withOpacity(0.4) : const Color(0xFFF3F4F6))
        : (isDark ? Colors.transparent : Colors.white);
    
    final borderColor = isDark ? const Color(0xFF262626) : const Color(0xFFE5E7EB);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(bottom: BorderSide(color: borderColor, width: 0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 130,
            height: 75,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF262626) : Colors.grey[200],
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    thumbnailUrl,
                    fit: BoxFit.cover,
                    opacity: const AlwaysStoppedAnimation(0.8),
                  ),
                ),
                if (showPlayBadge)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      width: 16,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.red[600],
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Center(
                        child: Icon(Icons.play_arrow, color: Colors.white, size: 8),
                      ),
                    ),
                  ),
                if (showUBadge)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFEF2F2),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'U',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (showProgressBar)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      color: Colors.black.withOpacity(0.6),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 4,
                            width: 65,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 2),
                          Container(
                            height: 4,
                            width: 100,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFigmaVideoListItem(bool isDark) {
    final borderColor = isDark ? const Color(0xFF262626) : const Color(0xFFE5E7EB);
    
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.transparent : Colors.white,
        border: Border(bottom: BorderSide(color: borderColor, width: 0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 130,
            height: 75,
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCnNBZ766564G66AQwCPv43xSpbCiIx2GCqlxXFa011keAjQz78FVecWP-5uwZR_KOMJxG9gdBiYaYYbtdBNj5692YF_hfXrEetWrY3atphSh6XaywTG1d4ubIerxCc9p5MN7bXp1HGx85l20meomcXFBU_6eHogEsITq74uXG2-p5eA_kWR1MDfvQxFQ6VnsrA_wMwPkPm5VgKEluQ3vZRKDJi6yfjMFRoSEB_slWHajksbC0o6bpdS_niadiuIlkQmB7B0YoNrrRq',
                    fit: BoxFit.cover,
                    opacity: const AlwaysStoppedAnimation(0.7),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: CustomPaint(
                          painter: FigmaLogoPainter(),
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Belajar Dasar',
                        style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Figma',
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuD-7dLzK0st2CICmtO5oKKOmpBlYULynH2pzfBWJYMst08y6BEghYEaGdp1lIN9AmH71SqLyYrlpKzvg6nimK1ZjD7DbuL_23awNA9w-Fnu6YGLf-xZsSmwqAbNp9HbdWAim4kxjtw0pd8OwiIvJZ1TFWw5KEQIZc6tepbtxPAHvNbsCwf_vGhXlD-wkNOI3QYLpN8i9jH_PWHtKvEtUcKOrvJYH09qFOkpAyo6dTyUdSDQcpftgWceq-aShmf7RYl_rYMflgxw4gcn',
                    width: 48,
                    height: 64,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Tutorial Dasar Figma – UI/UX Design Software',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class FigmaLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    
    // Simple figma-like shape representation
    final paintRed = Paint()..color = Colors.red;
    final paintYellow = Paint()..color = Colors.orange;
    final paintPurple = Paint()..color = Colors.purple;
    final paintBlue = Paint()..color = Colors.blue;
    final paintGreen = Paint()..color = Colors.green;

    canvas.drawRRect(RRect.fromLTRBAndCorners(0, 0, w/2, h/3, topLeft: Radius.circular(w/4), bottomLeft: Radius.circular(w/4)), paintRed);
    canvas.drawRRect(RRect.fromLTRBAndCorners(w/2, 0, w, h/3, topRight: Radius.circular(w/4), bottomRight: Radius.circular(w/4)), paintYellow);
    canvas.drawRRect(RRect.fromLTRBAndCorners(0, h/3, w/2, 2*h/3, topLeft: Radius.circular(w/4), bottomLeft: Radius.circular(w/4)), paintPurple);
    canvas.drawCircle(Offset(3*w/4, h/2), w/4, paintBlue);
    canvas.drawRRect(RRect.fromLTRBAndCorners(0, 2*h/3, w/2, h, topLeft: Radius.circular(w/4), bottomLeft: Radius.circular(w/4)), paintGreen);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
