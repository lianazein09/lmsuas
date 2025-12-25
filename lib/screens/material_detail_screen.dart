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
      'type': 'pdf',
      'title': 'Pengenalan UI Design.pdf',
      'size': '2.4 MB',
      'time': 'Diupload 2 hari lalu',
      'completed': true,
    },
    {
      'type': 'pptx',
      'title': 'Prinsip Desain Visual.pptx',
      'size': '5.1 MB',
      'time': 'Diupload 3 hari lalu',
      'completed': false,
    },
    {
      'type': 'pdf',
      'title': 'Studi Kasus Antarmuka.pdf',
      'size': '1.8 MB',
      'time': 'Diupload 5 hari lalu',
      'completed': false,
    },
    {
      'type': 'docx',
      'title': 'Panduan Tugas Besar.docx',
      'size': '850 KB',
      'time': 'Diupload 1 minggu lalu',
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
    final cardColor = isDark ? const Color(0xFF1F2937).withOpacity(0.5) : const Color(0xFFF9FAFB);
    final borderColor = isDark ? const Color(0xFF374151) : const Color(0xFFF3F4F6);
    final textColor = isDark ? Colors.white : const Color(0xFF111827);
    final secondaryTextColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    // Get icon and color based on type
    IconData icon;
    Color iconColor;
    Color iconBgColor;

    switch (attachment['type']) {
      case 'pdf':
        icon = Icons.picture_as_pdf_rounded;
        iconColor = const Color(0xFFEF4444); // Red-500
        iconBgColor = isDark ? const Color(0xFF7F1D1D).withOpacity(0.2) : const Color(0xFFFEF2F2);
        break;
      case 'pptx':
        icon = Icons.slideshow_rounded;
        iconColor = const Color(0xFFF97316); // Orange-500
        iconBgColor = isDark ? const Color(0xFF7C2D12).withOpacity(0.2) : const Color(0xFFFFF7ED);
        break;
      case 'docx':
        icon = Icons.description_rounded;
        iconColor = const Color(0xFF3B82F6); // Blue-500
        iconBgColor = isDark ? const Color(0xFF1E3A8A).withOpacity(0.2) : const Color(0xFFEFF6FF);
        break;
      default:
        icon = Icons.insert_drive_file_rounded;
        iconColor = secondaryTextColor;
        iconBgColor = isDark ? Colors.grey[800]! : Colors.grey[100]!;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attachment['title'],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${attachment['size']} • ${attachment['time']}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Download Icon
          Icon(
            Icons.download_rounded,
            color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
            size: 20,
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
