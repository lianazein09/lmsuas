import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  // Colors from the HTML design
  static const Color primaryColor = Color(0xFF1D4ED8);
  static const Color purpleColor = Color(0xFF9333EA);

  // Notification data
  static final List<Map<String, dynamic>> _notifications = [
    {
      'type': 'document',
      'title': 'Pengumpulan Laporan Akhir Assessment 3 (Tugas Besar)',
      'time': '3 Hari 9 Jam Yang Lalu',
    },
    {
      'type': 'quiz',
      'title': 'Pengumpulan Laporan Akhir Assessment 3 (Tugas Besar)',
      'time': '3 Hari 9 Jam Yang Lalu',
    },
    {
      'type': 'document',
      'title': 'Pengumpulan Laporan Akhir Assessment 3 (Tugas Besar)',
      'time': '3 Hari 9 Jam Yang Lalu',
    },
    {
      'type': 'quiz',
      'title': 'Pengumpulan Laporan Akhir Assessment 3 (Tugas Besar)',
      'time': '3 Hari 9 Jam Yang Lalu',
    },
    {
      'type': 'document',
      'title': 'Pengumpulan Laporan Akhir Assessment 3 (Tugas Besar)',
      'time': '3 Hari 9 Jam Yang Lalu',
    },
    {
      'type': 'document',
      'title': 'Pengumpulan Laporan Akhir Assessment 3 (Tugas Besar)',
      'time': '3 Hari 9 Jam Yang Lalu',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF121212) : Colors.white;
    final textColor = isDark ? const Color(0xFFE5E7EB) : const Color(0xFF111827);
    final subTextColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              // Header
              _buildHeader(context, isDark, backgroundColor, textColor),
              // Notification list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) {
                    return _buildNotificationItem(
                      _notifications[index],
                      isDark,
                      textColor,
                      subTextColor,
                    );
                  },
                ),
              ),
            ],
          ),
          _buildBottomNav(context),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFB02E2E), // Using home's primary color for consistency
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(context, Icons.home_rounded, 'Home', false, 0),
                _buildNavItem(context, Icons.school_rounded, 'Kelas Saya', false, 1),
                _buildNavItem(context, Icons.notifications_rounded, 'Notifikasi', true, 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, bool isSelected, int index) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else if (index == 1) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white.withValues(alpha: 0.2) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white.withValues(alpha: isSelected ? 1 : 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

  Widget _buildHeader(BuildContext context, bool isDark, Color backgroundColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      decoration: BoxDecoration(
        color: isDark 
            ? backgroundColor.withValues(alpha: 0.95) 
            : backgroundColor.withValues(alpha: 0.95),
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
              Icons.arrow_back,
              color: textColor,
              size: 24,
            ),
            padding: const EdgeInsets.all(8),
            style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
          ),
          // Title centered
          Expanded(
            child: Text(
              'Notifikasi',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
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

  Widget _buildNotificationItem(
    Map<String, dynamic> notification,
    bool isDark,
    Color textColor,
    Color subTextColor,
  ) {
    final isDocument = notification['type'] == 'document';
    final iconColor = isDocument ? primaryColor : purpleColor;
    final iconBgColor = isDocument
        ? (isDark ? primaryColor.withValues(alpha: 0.2) : const Color(0xFFEFF6FF))
        : (isDark ? purpleColor.withValues(alpha: 0.2) : const Color(0xFFFAF5FF));

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.transparent,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isDocument ? Icons.description_outlined : Icons.quiz_outlined,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: textColor,
                      height: 1.4,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Anda telah mengirimkan pengajuan tugas untuk ',
                      ),
                      TextSpan(
                        text: notification['title'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  notification['time'],
                  style: GoogleFonts.inter(
                    fontSize: 12,
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
}
