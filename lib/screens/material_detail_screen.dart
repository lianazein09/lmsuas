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
  static const Color primaryColor = Color(0xFF10B981);

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
      padding: const EdgeInsets.only(top: 48, bottom: 8),
      color: backgroundColor,
      width: double.infinity,
      child: Center(
        child: Container(
          width: 48,
          height: 6,
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[700] : Colors.grey[200],
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
            color: isDark ? Colors.grey[800]! : Colors.grey[100]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Lampiran Materi tab
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _selectedTab == 0 
                          ? (isDark ? Colors.white : Colors.black) 
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  'Lampiran Materi',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: _selectedTab == 0 ? FontWeight.w600 : FontWeight.w500,
                    color: _selectedTab == 0 ? textColor : inactiveColor,
                  ),
                ),
              ),
            ),
          ),
          // Tugas dan Kuis tab
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = 1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _selectedTab == 1 
                          ? (isDark ? Colors.white : Colors.black) 
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  'Tugas dan Kuis',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: _selectedTab == 1 ? FontWeight.w600 : FontWeight.w500,
                    color: _selectedTab == 1 ? textColor : inactiveColor,
                  ),
                ),
              ),
            ),
          ),
        ],
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
              color: attachment['completed'] ? primaryColor : (isDark ? Colors.grey[600] : Colors.grey[300]),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 64,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Tidak ada tugas dan kuis untuk materi ini',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
