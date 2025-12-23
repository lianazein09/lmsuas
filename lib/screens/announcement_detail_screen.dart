import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnnouncementDetailScreen extends StatefulWidget {
  final Map<String, String>? announcement;

  const AnnouncementDetailScreen({super.key, this.announcement});

  @override
  State<AnnouncementDetailScreen> createState() => _AnnouncementDetailScreenState();
}

class _AnnouncementDetailScreenState extends State<AnnouncementDetailScreen> {
  int _selectedNavIndex = 0;

  // Colors from the HTML design
  static const Color primaryColor = Color(0xFFA64444);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF111827) : Colors.white;
    final textColor = isDark ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937);
    final mutedTextColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              // Header
              _buildHeader(context, isDark, backgroundColor, textColor),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        widget.announcement?['title'] ?? 'Maintenance Pra UAS Semester Genap 2020/2021',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Author info
                      _buildAuthorInfo(isDark, textColor, mutedTextColor),
                      const SizedBox(height: 24),
                      // Image
                      _buildImage(isDark),
                      const SizedBox(height: 32),
                      // Article content
                      _buildArticleContent(isDark, textColor, mutedTextColor),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Bottom navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark, Color backgroundColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey[800]! : Colors.grey[100]!,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: textColor,
              size: 24,
            ),
            padding: const EdgeInsets.all(8),
          ),
          // Title centered
          Expanded(
            child: Text(
              'Pengumuman',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: textColor,
                letterSpacing: 0.5,
              ),
            ),
          ),
          // Placeholder for symmetry
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildAuthorInfo(bool isDark, Color textColor, Color mutedTextColor) {
    return Row(
      children: [
        // Avatar
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? Colors.grey[700] : Colors.grey[200],
            border: Border.all(
              color: isDark ? Colors.grey[600]! : Colors.grey[100]!,
              width: 1,
            ),
          ),
          child: ClipOval(
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDwF9eJQMbsexa_KWR9mWtk3AMDmodPWXwCS-1krM6Zjno1DoiGGLJfn9OpkwHXolt--ww5FxPpas0tbiCzuBRliy3v4P2dYZwAAvXt78BJy1MCmI70UTIRZQ6jUB-NcaEe1mRz6U3uxTPGWEAdOQCCl4hBGPFz2rDb_UjHdKakeMhxg41IU-I9hyhooKFawGncaDaXs5Mxx2iGY9xzedlwW6ar4GTd1yqQaZH-77QsE8Ltk4Bo5PdkzJgzjJcKVUNlYIDvaLsznCQ',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(
                Icons.person,
                color: isDark ? Colors.grey[400] : Colors.grey[500],
                size: 24,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Author details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'By ${widget.announcement?['author'] ?? 'Admin Celoe'}',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              widget.announcement?['date'] ?? 'Rabu, 2 Juni 2021, 10:45',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: mutedTextColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImage(bool isDark) {
    return Container(
      width: double.infinity,
      height: 192,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDark ? Colors.grey[800] : const Color(0xFFEFF6FF),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[100]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDDFR-EerWSEsQ2qD-MGOARiWphJjw3xnhmIaQxzCUgTUraIctg9V5ITf8Q7YEQUHmIhfqL6GEC-POJxhxKSSq-JSv7pF1ltmgCLwq8yiUr2yUI06z7QuSQZtHH2_Hdk9sJ8PB65hwQjVLq8ownKCGpFX3h9vVn_1qqoFW8SAang36xFwxop3M4txaByRsbloQG7Vj1iyBCUPGhJE22X3pwTgPhIsoZOlx7l1SBlSO4hsQ7DEISmVeV8v82Zd2PZthdVsiCcBX9aJw',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.9),
              errorBuilder: (_, __, ___) => Center(
                child: Icon(
                  Icons.image_outlined,
                  color: isDark ? Colors.grey[600] : Colors.grey[400],
                  size: 48,
                ),
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleContent(bool isDark, Color textColor, Color mutedTextColor) {
    final contentColor = isDark ? Colors.grey[300] : Colors.grey[600];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Subtitle
        Center(
          child: Text(
            'Maintenance LMS',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Paragraph 1
        Text(
          'Diinformasikan kepada seluruh pengguna LMS, kami dari tim CeLOE akan melakukan maintenance pada tanggal 12 Juni 2021, untuk meningkatkan layanan server dalam menghadapi ujian akhir semester (UAS).',
          textAlign: TextAlign.justify,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: contentColor,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        // Paragraph 2
        Text(
          'Dengan adanya kegiatan maintenance tersebut maka situs LMS (lms.telkomuniversity.ac.id) tidak dapat diakses mulai pukul 00.00 s/d 06.00 WIB.',
          textAlign: TextAlign.justify,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: contentColor,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        // Paragraph 3
        Text(
          'Demikian informasi ini kami sampaikan, mohon maaf atas ketidaknyamanannya.',
          textAlign: TextAlign.justify,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: contentColor,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 40),
        // Signature
        Text(
          'Hormat Kami,',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'CeLOE Telkom University',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 30,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', 0, hasBackground: true),
              _buildNavItem(Icons.school, 'Kelas Saya', 1),
              _buildNavItem(Icons.notifications, 'Notifikasi', 2, hasNotification: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, {bool hasBackground = false, bool hasNotification = false}) {
    final isSelected = _selectedNavIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedNavIndex = index),
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: hasBackground ? Colors.white.withValues(alpha: 0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white.withValues(alpha: isSelected ? 1 : 0.9),
                    size: 24,
                  ),
                ),
                if (hasNotification)
                  Positioned(
                    top: 0,
                    right: -2,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.yellow[400],
                        shape: BoxShape.circle,
                        border: Border.all(color: primaryColor, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
