import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialDetailScreen extends StatefulWidget {
  final String? title;
  final String? description;

  const MaterialDetailScreen({super.key, this.title, this.description});

  @override
  State<MaterialDetailScreen> createState() => _MaterialDetailScreenState();
}

class _MaterialDetailScreenState extends State<MaterialDetailScreen> {
  int _selectedTab = 0; // 0: Lampiran Materi, 1: Tugas dan Kuis

  // Colors from the HTML design
  static const Color primaryColor = Color(0xFF111827);
  static const Color accentGreen = Color(0xFF10B981);

  // Attachments data
  final List<Map<String, dynamic>> _attachments = [
    {
      'type': 'link',
      'title': 'Zoom Meeting Synchronous',
      'completed': true,
    },
    {
      'type': 'document',
      'title': 'Pengantar User Interface Design',
      'completed': false,
    },
    {
      'type': 'document',
      'title': 'Empat Teori Dasar Antarmuka Pengguna',
      'completed': false,
    },
    {
      'type': 'document',
      'title': 'Empat Teori Dasar Antarmuka Pengguna',
      'completed': true,
    },
    {
      'type': 'video',
      'title': 'User Interface Design for Beginner',
      'completed': true,
    },
    {
      'type': 'link',
      'title': '20 Prinsip Desain',
      'completed': true,
    },
    {
      'type': 'link',
      'title': 'Best Practice UI Design',
      'completed': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1F2937) : Colors.white;
    final textColor = isDark ? const Color(0xFFF9FAFB) : const Color(0xFF111827);
    final secondaryTextColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Handle bar
            _buildHandleBar(isDark, backgroundColor),
            // Header
            _buildHeader(textColor),
            // Description
            _buildDescription(secondaryTextColor),
            // Tab bar
            _buildTabBar(isDark, textColor),
            // Content
            _selectedTab == 0
                ? _buildAttachmentsList(isDark)
                : _buildTugasContent(isDark),
            const SizedBox(height: 48), // Bottom space
          ],
        ),
      ),
    );
  }

  Widget _buildHandleBar(bool isDark, Color backgroundColor) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      color: backgroundColor,
      width: double.infinity,
      child: Center(
        child: Container(
          width: 64,
          height: 6,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color textColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      child: Text(
        widget.title ?? 'Pengantar User Interface Design',
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textColor,
          height: 1.3,
        ),
      ),
    );
  }

  Widget _buildDescription(Color secondaryTextColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deskripsi',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: secondaryTextColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.description ?? 
                'Antarmuka yang dibangun harus memperhatikan prinsip-prinsip desain yang ada. Hal ini diharapkan agar antarmuka yang dibangun bukan hanya menarik secara visual tetapi dengan memperhatikan kaidah-kaidah prinsip desain diharapkan akan mendukung pengguna dalam menggunakan produk secara baik. Pelajaran mengenai prinsip UID ini sudah pernah diajarkan dalam mata kuliah Implementasi Desain Antarmuka Pengguna tetap pada matakuliah ini akan direview kembali sehingga dapat menjadi bekal saat memasukki materi mengenai User Experience.',
            textAlign: TextAlign.justify,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: secondaryTextColor,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(bool isDark, Color textColor) {
    final bgColor = isDark ? const Color(0xFF374151).withValues(alpha: 0.5) : const Color(0xFFF9FAFB);
    final inactiveColor = isDark ? Colors.grey[500] : Colors.grey[400];

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          bottom: BorderSide(
            color: isDark ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Lampiran Materi tab
          _buildTabItem(
            label: 'Lampiran Materi',
            index: 0,
            isDark: isDark,
            textColor: textColor,
            inactiveColor: inactiveColor!,
          ),
          // Tugas dan Kuis tab
          _buildTabItem(
            label: 'Tugas dan Kuis',
            index: 1,
            isDark: isDark,
            textColor: textColor,
            inactiveColor: inactiveColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required String label,
    required int index,
    required bool isDark,
    required Color textColor,
    required Color inactiveColor,
  }) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? textColor : inactiveColor,
                ),
              ),
              if (isSelected)
                Positioned(
                  bottom: -16,
                  child: Container(
                    width: 64,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white : primaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttachmentsList(bool isDark) {
    final bgColor = isDark ? Colors.transparent : const Color(0xFFF9FAFB).withValues(alpha: 0.5);

    return Container(
      color: bgColor,
      child: ListView.builder(
        padding: const EdgeInsets.all(24),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _attachments.length,
        itemBuilder: (context, index) {
          return _buildAttachmentCard(_attachments[index], isDark);
        },
      ),
    );
  }

  Widget _buildAttachmentCard(Map<String, dynamic> attachment, bool isDark) {
    final cardColor = isDark ? Colors.grey[800] : Colors.white;
    final textColor = isDark ? const Color(0xFFF9FAFB) : const Color(0xFF111827);
    final iconBgColor = isDark ? Colors.grey[700] : Colors.grey[50];
    final iconColor = isDark ? Colors.grey[300] : Colors.grey[700];

    // Get icon based on type
    IconData icon;
    double rotation = 0;
    switch (attachment['type']) {
      case 'link':
        icon = Icons.link;
        rotation = 0.785; // 45 degrees in radians
        break;
      case 'video':
        icon = Icons.videocam_outlined;
        break;
      case 'document':
      default:
        icon = Icons.description_outlined;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.grey[700]! : Colors.transparent,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Transform.rotate(
                angle: rotation,
                child: Icon(icon, color: iconColor, size: 20),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Title
          Expanded(
            child: Text(
              attachment['title'],
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          // Status
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: attachment['completed'] ? accentGreen : (isDark ? Colors.grey[600] : Colors.grey[300]),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTugasContent(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(32, 48, 32, 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration from HTML
          Container(
            width: 256,
            height: 256,
            margin: const EdgeInsets.only(bottom: 24),
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuBXtzoT9TSVNsyoAS2wd7onrU0KjfS_70pKlCHa7brimZN9Qmo0urPM2NewUqEXO_7keFyKg5rQKny1wDbfw17qjTwo3lTvQtFHKWN-_EfmLaqSQs_8UF-UxXjotMk9pduceMrYLi8J0XfAixSFYSdHzqBEkpLTZJT6Z3Qrl5oGyulfOObeA8nQwMb4zMfCfpHvijlaT8uLwQytRB44rLMdfqBgFrh2Ph54dqfjI81yoZdB_ctBHiK1bx2x57AcIBoa2rmkv1JiRfmI',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Icon(
                Icons.assignment_outlined,
                size: 64,
                color: isDark ? Colors.grey[600] : Colors.grey[400],
              ),
            ),
          ),
          Text(
            'Tidak Ada Tugas Dan Kuis Hari Ini',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : const Color(0xFF111827),
            ),
          ),
        ],
      ),
    );
  }
}
