import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'material_viewer_screen.dart';
import 'assignment_detail_screen.dart';

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
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF18181B);
  static const Color surfaceLight = Color(0xFFF3F4F6);
  static const Color surfaceDark = Color(0xFF27272A);
  static const Color borderLight = Color(0xFFF3F4F6);
  static const Color borderDark = Color(0xFF3F3F46);
  static const Color textSecondaryLight = Color(0xFF4B5563);
  static const Color textSecondaryDark = Color(0xFFA1A1AA);

  // Attachments data
  final List<Map<String, dynamic>> _attachments = [
    {
      'type': 'link',
      'title': 'Zoom Meeting Syncronous',
      'completed': true,
    },
    {
      'type': 'document',
      'title': 'Elemen-elemen Antarmuka Pengguna',
      'completed': true,
    },
    {
      'type': 'document',
      'title': 'UID Guidelines and Principles',
      'completed': true,
    },
    {
      'type': 'document',
      'title': 'User Profile',
      'completed': true,
    },
    {
      'type': 'link',
      'title': 'Principles of User Interface DesignURL',
      'completed': true,
    },
  ];

  // Assignments data
  final List<Map<String, dynamic>> _assignmentsList = [
    {
      'type': 'quiz',
      'title': 'Quiz Review 01',
      'description': 'Silahkan kerjakan kuis ini dalam waktu 15 menit sebagai nilai pertama komponen kuis. Jangan lupa klik tombol Submit Answer setelah menjawab seluruh pertanyaan.',
      'deadline': "Kerjakan sebelum hari Jum'at, 26 Februari 2021 jam 23:59 WIB.",
      'completed': true,
      'icon': Icons.chat_bubble_outline_rounded,
    },
    {
      'type': 'assignment',
      'title': 'Tugas 01 - UID Android Mobile Game',
      'description': '1. Buatlah desain tampilan (antarmuka) pada aplikasi mobile game FPS (First Person Shooter) yang akan menjadi tugas pada mata kuliah Pemrograman Aplikasi Permainan.\n2. Desain yang dibuat harus melingkupi seluruh tampilan pada aplikasi/game, dari pertama kali aplikasi ............',
      'deadline': '',
      'completed': true,
      'isGrayCheck': true,
      'icon': Icons.assignment_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? backgroundDark : backgroundLight;
    final textColor = isDark ? const Color(0xFFF9FAFB) : const Color(0xFF111827);
    final secondaryTextColor = isDark ? textSecondaryDark : textSecondaryLight;
    final borderColor = isDark ? borderDark : borderLight;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFE5E7EB),
      body: Column(
        children: [
          // Handle Bar (Top notch)
          Container(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            color: bgColor,
            child: Center(
              child: Container(
                width: 48,
                height: 6,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF3F3F46) : const Color(0xFFD1D5DB),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
          // Scrollable Content
          Expanded(
            child: Container(
              color: bgColor,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Header Title
                    _buildHeadline(textColor),
                    // Description Section
                    _buildDescription(secondaryTextColor),
                    // Tab Bar
                    _buildTabBar(isDark, textColor, borderColor),
                    // Content Area
                    Container(
                      color: bgColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        child: _selectedTab == 0
                            ? _buildAttachmentsList(isDark)
                            : _buildTugasContent(isDark),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline(Color textColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      child: Text(
        widget.title ?? 'Konsep User Interface Design',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildDescription(Color secondaryTextColor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? const Color(0xFFF4F4F5) : const Color(0xFF111827);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deskripsi',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.description ?? 
                'Konsep dasar User Interface Design akan dipelajari bagaimana membangun sebuah Interaction Design pada antarmuka. Interaction ini sangat penting untuk aplikasi berkomunikasi dengan pengguna. Lalu dipelajari juga poin-poin penting pada interaction design seperti visibility, feedback, limitation, consistency dan affordance. Dan terakhir materi conceptual and perceptual design interaction akan memberikan gambaran bagaimana bentuk dari interaction.',
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: secondaryTextColor,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(bool isDark, Color textColor, Color borderColor) {
    final bgColor = isDark ? surfaceDark : surfaceLight;
    final inactiveColor = isDark ? const Color(0xFFA1A1AA) : const Color(0xFF6B7280);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? textColor : inactiveColor,
                ),
              ),
              if (isSelected)
                Positioned(
                  bottom: -4,
                  child: Container(
                    width: 120, // Adjusted width for better look
                    height: 3,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white : const Color(0xFF111827),
                      borderRadius: BorderRadius.circular(1.5),
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
    return ListView.builder(
      padding: EdgeInsets.zero,
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
    final cardBg = isDark ? const Color(0xFF1F2937).withOpacity(0.5) : const Color(0xFFF9FAFB);
    final borderColor = isDark ? const Color(0xFF374151) : const Color(0xFFF3F4F6);
    final textColor = isDark ? Colors.white : const Color(0xFF111827);
    final secondaryTextColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    // Get icon and color based on type
    IconData icon;
    double rotation = 0;

    switch (attachment['type']) {
      case 'link':
        icon = Icons.link_rounded;
        rotation = 0.785; // 45 degrees
        break;
      case 'document':
      default:
        icon = Icons.description_rounded;
    }

    return GestureDetector(
      onTap: () {
        if (attachment['type'] == 'document' || attachment['title'].contains('Elemen')) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MaterialViewerScreen(
                title: 'Pengantar User Interface Design',
              ),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(24), // rounded-[1.5rem]
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              spreadRadius: -2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(4),
              child: Transform.rotate(
                angle: rotation,
                child: Icon(
                  icon,
                  color: isDark ? const Color(0xFFD4D4D8) : const Color(0xFF374151),
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Title
            Expanded(
              child: Text(
                attachment['title'],
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 16),
            // Status Check
            Icon(
              Icons.check_circle_rounded,
              color: primaryColor,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTugasContent(bool isDark) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _assignmentsList.length,
      itemBuilder: (context, index) {
        return _buildAssignmentCardItem(_assignmentsList[index], isDark);
      },
    );
  }

  Widget _buildAssignmentCardItem(Map<String, dynamic> assignment, bool isDark) {
    final textColor = isDark ? const Color(0xFFF9FAFB) : const Color(0xFF111827);
    final secondaryTextColor = isDark ? textSecondaryDark : textSecondaryLight;
    final cardBg = isDark ? surfaceDark : Colors.white;
    final isCompleted = assignment['completed'] == true;
    final isGrayCheck = assignment['isGrayCheck'] == true;
    final borderColor = isDark ? borderDark : const Color(0xFFE5E7EB);

    return GestureDetector(
      onTap: () {
        if (assignment['type'] == 'assignment') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AssignmentDetailScreen(
                title: assignment['title'],
              ),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Icon Side
              Container(
                width: 64,
                decoration: BoxDecoration(
                  color: cardBg,
                  border: Border(
                    right: BorderSide(color: isDark ? const Color(0xFF4B5563) : const Color(0xFFF3F4F6)),
                  ),
                ),
                child: Center(
                  child: Icon(
                    assignment['icon'] as IconData,
                    color: textColor,
                    size: 24,
                  ),
                ),
              ),
              // Content Side
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Check
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: isDark ? const Color(0xFF4B5563) : const Color(0xFFF3F4F6)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                assignment['title'],
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                            ),
                            if (isCompleted)
                              Icon(
                                Icons.check_circle_outline_rounded,
                                color: isGrayCheck 
                                    ? (isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF)) 
                                    : primaryColor,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                      // Description
                      Text(
                        assignment['description'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: secondaryTextColor,
                          height: 1.5,
                        ),
                      ),
                      if (assignment['deadline'].isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          assignment['deadline'],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isDark ? const Color(0xFFE5E7EB) : const Color(0xFF111827),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
