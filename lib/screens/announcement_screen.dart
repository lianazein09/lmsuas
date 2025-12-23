import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  int _selectedNavIndex = 0;

  // Colors from the HTML design
  static const Color primaryColor = Color(0xFFBA4D49);

  // Announcement data
  static final List<Map<String, String>> _announcements = [
    {
      'title': 'Maintenance Pra UAS Semester Genap 2020/2021',
      'author': 'Admin Celoe',
      'date': 'Rabu, 2 Juni 2021, 10:45',
    },
    {
      'title': 'Pengumuman Maintance',
      'author': 'Admin Celoe',
      'date': 'Senin, 11 Januari 2021, 7:52',
    },
    {
      'title': 'Maintenance Pra UAS Semeter Ganjil 2020/2021',
      'author': 'Admin Celoe',
      'date': 'Minggu, 10 Januari 2021, 9:30',
    },
    {
      'title': 'Libur Nasional Idul Fitri 1442 H',
      'author': 'Admin Celoe',
      'date': 'Jumat, 14 Mei 2021, 08:00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF18181B) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF111827);
    final subTextColor = isDark ? Colors.grey[400] : Colors.grey[500];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              // Header
              _buildHeader(context, isDark, backgroundColor, textColor),
              // Announcement list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                  itemCount: _announcements.length,
                  itemBuilder: (context, index) {
                    return _buildAnnouncementItem(
                      _announcements[index],
                      isDark,
                      textColor,
                      subTextColor!,
                    );
                  },
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
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_rounded,
              color: textColor,
              size: 28,
            ),
            padding: const EdgeInsets.all(8),
            style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
          ),
          // Title centered
          Expanded(
            child: Text(
              'Pengumuman',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ),
          // Placeholder for symmetry
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildAnnouncementItem(
    Map<String, String> announcement,
    bool isDark,
    Color textColor,
    Color subTextColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Campaign icon with rotation
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Transform.rotate(
              angle: -0.2, // Slight rotation like in HTML
              child: Icon(
                Icons.campaign_rounded,
                color: textColor,
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  announcement['title']!,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'By ${announcement['author']} - ${announcement['date']}',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: subTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_rounded, 'Home', 0),
              _buildNavItem(Icons.school_rounded, 'Kelas Saya', 1),
              _buildNavItem(Icons.notifications_rounded, 'Notifikasi', 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedNavIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedNavIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white.withValues(alpha: isSelected ? 1 : 0.8),
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: isSelected ? 1 : 0.8),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
