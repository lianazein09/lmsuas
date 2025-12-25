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
  static const Color primaryColor = Color(0xFF13EC5B);
  static const Color backgroundLight = Color(0xFFF6F8F6);
  static const Color backgroundDark = Color(0xFF102216);
  static const Color surfaceDark = Color(0xFF1A2E22);
  static const Color accentGreen = Color(0xFF13EC5B);

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

  // Assignments data
  final List<Map<String, dynamic>> _assignmentsList = [
    {
      'type': 'quiz',
      'title': 'Quiz Review 01',
      'description': 'Review fundamental concepts of UI.',
      'deadline': 'Deadline: Oct 24',
      'completed': true,
    },
    {
      'type': 'assignment',
      'title': 'Tugas 01 - UID Android Mobile Game',
      'description': 'Design the main menu for a mobile game.',
      'deadline': 'Deadline: Oct 30',
      'completed': false,
      'isUrgent': true,
    },
    {
      'type': 'note',
      'title': 'Tugas 02 - Wireframing',
      'description': 'Create low-fidelity wireframes.',
      'deadline': 'Deadline: Nov 05',
      'completed': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? backgroundDark : backgroundLight;
    final textColor = isDark ? Colors.white : const Color(0xFF0D1B12);
    final secondaryTextColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF0D1B12).withOpacity(0.8);

    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          // App Bar
          _buildAppBar(context, isDark, textColor),
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Headline Section
                  _buildHeadline(textColor),
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
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDark, Color textColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 8),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
            color: textColor,
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(8),
            ),
          ),
          Text(
            'Course Details',
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(width: 48), // Placeholder for symmetry
        ],
      ),
    );
  }

  Widget _buildHeadline(Color textColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        widget.title ?? 'Konsep User Interface Design',
        style: GoogleFonts.lexend(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textColor,
          height: 1.2,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  Widget _buildDescription(Color secondaryTextColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Text(
        widget.description ?? 
            'User Interface Design focuses on anticipating what users might need to do and ensuring that the interface has elements that are easy to access, understand, and use to facilitate those actions.',
        style: GoogleFonts.lexend(
          fontSize: 16,
          color: secondaryTextColor,
          height: 1.5,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildTabBar(bool isDark, Color textColor) {
    final bgColor = isDark ? const Color(0xFF374151).withValues(alpha: 0.5) : const Color(0xFFF9FAFB);
    final inactiveColor = isDark ? Colors.grey[500] : Colors.grey[400];

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isDark ? const Color(0xFF374151) : const Color(0xFFCFE7D7),
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
                style: GoogleFonts.lexend(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? textColor : inactiveColor,
                ),
              ),
              if (isSelected)
                Positioned(
                  bottom: -16,
                  child: Container(
                    width: double.infinity,
                    height: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white : primaryColor,
                      borderRadius: BorderRadius.circular(2),
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
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
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
        color: isDark ? surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
        shadows: isDark ? null : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
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
                  style: GoogleFonts.lexend(
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
                  style: GoogleFonts.lexend(
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
    if (_assignmentsList.isEmpty) {
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
              style: GoogleFonts.lexend(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : const Color(0xFF111827),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _assignmentsList.length,
        itemBuilder: (context, index) {
          return _buildAssignmentCardItem(_assignmentsList[index], isDark);
        },
      ),
    );
  }

  Widget _buildAssignmentCardItem(Map<String, dynamic> assignment, bool isDark) {
    final textColor = isDark ? Colors.white : const Color(0xFF0D1B12);
    final secondaryTextColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
    final isCompleted = assignment['completed'] == true;
    final isUrgent = assignment['isUrgent'] == true;

    // Icon based on type
    IconData icon;
    Color iconBgColor;
    Color iconColor;

    switch (assignment['type']) {
      case 'quiz':
        icon = Icons.quiz_rounded;
        iconColor = primaryColor;
        iconBgColor = isDark ? const Color(0xFF1E3A29) : const Color(0xFFE7F3EB);
        break;
      case 'assignment':
        icon = Icons.assignment_rounded;
        iconColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
        iconBgColor = isDark ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6);
        break;
      case 'note':
        icon = Icons.sticky_note_2_rounded;
        iconColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
        iconBgColor = isDark ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6);
        break;
      default:
        icon = Icons.assignment_rounded;
        iconColor = primaryColor;
        iconBgColor = isDark ? const Color(0xFF1E3A29) : const Color(0xFFE7F3EB);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6)),
        shadows: isDark ? null : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
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
                  assignment['title'],
                  style: GoogleFonts.lexend(
                    fontSize: 16,
                    fontWeight: FontWeight.semibold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  assignment['description'],
                  style: GoogleFonts.lexend(
                    fontSize: 14,
                    color: secondaryTextColor,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  assignment['deadline'],
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isUrgent ? Colors.red[400] : (isCompleted ? primaryColor : secondaryTextColor),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Status
          if (isCompleted)
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded, color: primaryColor, size: 24),
            )
          else
            Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(top: 4, right: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? const Color(0xFF374151) : const Color(0xFFD1D5DB),
                  width: 2,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
