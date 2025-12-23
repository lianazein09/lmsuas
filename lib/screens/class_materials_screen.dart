import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClassMaterialsScreen extends StatefulWidget {
  final String? className;
  final String? classCode;

  const ClassMaterialsScreen({super.key, this.className, this.classCode});

  @override
  State<ClassMaterialsScreen> createState() => _ClassMaterialsScreenState();
}

class _ClassMaterialsScreenState extends State<ClassMaterialsScreen> {
  int _selectedTab = 0; // 0: Materi, 1: Tugas Dan Kuis
  int _selectedNavIndex = 1;

  // Colors from the HTML design
  static const Color primaryColor = Color(0xFFBD4B4B);
  static const Color secondaryColor = Color(0xFF5CA8E6);
  static const Color successColor = Color(0xFF2ECC71);

  // Materials data
  final List<Map<String, dynamic>> _materials = [
    {
      'meeting': 'Pertemuan 1',
      'title': '01 - Pengantar User Interface Design',
      'content': '3 URLs, 2 Files, 3 Interactive Content',
      'completed': false,
    },
    {
      'meeting': 'Pertemuan 2',
      'title': '02 - Konsep User Interface Design',
      'content': '2 URLs, 1 Kuis, 3 Files, 1 Tugas',
      'completed': true,
    },
    {
      'meeting': 'Pertemuan 3',
      'title': '03 - Interaksi pada User Interface Design',
      'content': '3 URLs, 2 Files, 3 Interactive Content',
      'completed': true,
    },
    {
      'meeting': 'Pertemuan 4',
      'title': '04 - Ethnographic Observation',
      'content': '3 URLs, 2 Files, 3 Interactive Content',
      'completed': true,
    },
    {
      'meeting': 'Pertemuan 5',
      'title': '05 - UID Testing',
      'content': '3 URLs, 2 Files, 3 Interactive Content',
      'completed': true,
    },
    {
      'meeting': 'Pertemuan 6',
      'title': '06 - Assessment 1',
      'content': '3 URLs, 2 Files, 3 Interactive Content',
      'completed': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF121212) : const Color(0xFFF0F2F5);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              // Header
              _buildHeader(context),
              // Tab bar
              _buildTabBar(isDark),
              // Content
              Expanded(
                child: _selectedTab == 0
                    ? _buildMaterialsList(isDark)
                    : _buildTugasContent(isDark),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 64),
      decoration: BoxDecoration(
        color: primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.only(top: 4),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Title
          Expanded(
            child: Text(
              widget.className?.toUpperCase() ?? 
                  'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA ${widget.classCode ?? 'D4SM-42-03 [ADY]'}',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.4,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(bool isDark) {
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1F2937);
    final subTextColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    return Transform.translate(
      offset: const Offset(0, -32),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          height: 56,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Materi tab
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedTab = 0),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Materi',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: _selectedTab == 0 ? FontWeight.w700 : FontWeight.w500,
                            color: _selectedTab == 0 ? textColor : subTextColor,
                          ),
                        ),
                        if (_selectedTab == 0) ...[
                          const SizedBox(height: 4),
                          Container(
                            width: 32,
                            height: 4,
                            decoration: BoxDecoration(
                              color: isDark ? Colors.white : Colors.black,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              // Tugas Dan Kuis tab
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedTab = 1),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tugas Dan Kuis',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: _selectedTab == 1 ? FontWeight.w700 : FontWeight.w500,
                            color: _selectedTab == 1 ? textColor : subTextColor,
                          ),
                        ),
                        if (_selectedTab == 1) ...[
                          const SizedBox(height: 4),
                          Container(
                            width: 32,
                            height: 4,
                            decoration: BoxDecoration(
                              color: isDark ? Colors.white : Colors.black,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ],
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

  Widget _buildMaterialsList(bool isDark) {
    return Transform.translate(
      offset: const Offset(0, -16),
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
        itemCount: _materials.length,
        itemBuilder: (context, index) {
          return _buildMaterialCard(_materials[index], isDark);
        },
      ),
    );
  }

  Widget _buildMaterialCard(Map<String, dynamic> material, bool isDark) {
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? const Color(0xFFF3F4F6) : const Color(0xFF1F2937);
    final subTextColor = isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[100]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Meeting tag and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Meeting tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: secondaryColor.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  material['meeting'],
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              // Status icon
              Icon(
                material['completed'] ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                color: material['completed'] ? successColor : (isDark ? Colors.grey[600] : Colors.grey[300]),
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Title
          Text(
            material['title'],
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          // Content description
          Text(
            material['content'],
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: subTextColor,
            ),
          ),
        ],
      ),
    );
  }

  // Tasks data
  final List<Map<String, dynamic>> _tasks = [
    {
      'type': 'quiz',
      'title': 'Quiz 1: Fundamentals',
      'dueDate': 'Due: Jumat, 25 Juni 2021, 23:59',
      'status': 'submitted',
      'score': '85/100',
      'isUrgent': false,
    },
    {
      'type': 'assignment',
      'title': 'Tugas Besar 1: Wireframing',
      'dueDate': 'Due: Senin, 28 Juni 2021, 23:59',
      'status': 'in_progress',
      'score': null,
      'isUrgent': true,
    },
    {
      'type': 'final_project',
      'title': 'Tugas Akhir: UI High Fidelity',
      'dueDate': 'Due: Rabu, 30 Juni 2021, 23:59',
      'status': 'not_started',
      'score': null,
      'isUrgent': false,
    },
    {
      'type': 'quiz',
      'title': 'Quiz 0: Pre-assessment',
      'dueDate': 'Due: Jumat, 10 Juni 2021, 23:59',
      'status': 'completed',
      'score': null,
      'isUrgent': false,
    },
  ];

  Widget _buildTugasContent(bool isDark) {
    final backgroundColor = isDark ? const Color(0xFF221010) : const Color(0xFFF8F6F6);
    final textColor = isDark ? const Color(0xFFF1F5F9) : const Color(0xFF1E293B);
    
    return Transform.translate(
      offset: const Offset(0, -16),
      child: Container(
        color: backgroundColor,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
          children: [
            // Section header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tasks',
                    style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[800] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '3 Active',
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Task list
            ..._tasks.map((task) => _buildTaskCard(task, isDark)),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task, bool isDark) {
    final cardColor = isDark ? const Color(0xFF27272A) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);
    
    // Get type-specific colors and icons
    IconData icon;
    Color iconBgColor;
    Color iconColor;
    Color tagBgColor;
    Color tagTextColor;
    String tagText;
    
    switch (task['type']) {
      case 'quiz':
        icon = Icons.quiz_outlined;
        iconBgColor = isDark ? const Color(0xFF581C87).withValues(alpha: 0.2) : const Color(0xFFF3E8FF);
        iconColor = isDark ? const Color(0xFFC084FC) : const Color(0xFF9333EA);
        tagBgColor = isDark ? const Color(0xFF581C87).withValues(alpha: 0.4) : const Color(0xFFF3E8FF);
        tagTextColor = isDark ? const Color(0xFFD8B4FE) : const Color(0xFF7C3AED);
        tagText = 'QUIZ';
        break;
      case 'assignment':
        icon = Icons.folder_open_outlined;
        iconBgColor = isDark ? const Color(0xFF9A3412).withValues(alpha: 0.2) : const Color(0xFFFFF7ED);
        iconColor = isDark ? const Color(0xFFFB923C) : const Color(0xFFEA580C);
        tagBgColor = isDark ? const Color(0xFF9A3412).withValues(alpha: 0.4) : const Color(0xFFFFF7ED);
        tagTextColor = isDark ? const Color(0xFFFDBA74) : const Color(0xFFC2410C);
        tagText = 'ASSIGNMENT';
        break;
      case 'final_project':
        icon = Icons.description_outlined;
        iconBgColor = isDark ? const Color(0xFF1E40AF).withValues(alpha: 0.2) : const Color(0xFFEFF6FF);
        iconColor = isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB);
        tagBgColor = isDark ? const Color(0xFF1E40AF).withValues(alpha: 0.4) : const Color(0xFFEFF6FF);
        tagTextColor = isDark ? const Color(0xFF93C5FD) : const Color(0xFF1D4ED8);
        tagText = 'FINAL PROJECT';
        break;
      default:
        icon = Icons.history_edu_outlined;
        iconBgColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;
        iconColor = isDark ? Colors.grey[400]! : Colors.grey[500]!;
        tagBgColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;
        tagTextColor = isDark ? Colors.grey[300]! : Colors.grey[600]!;
        tagText = 'QUIZ';
    }

    final isCompleted = task['status'] == 'submitted' || task['status'] == 'completed';
    final isUrgent = task['isUrgent'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: isUrgent 
            ? const Border(left: BorderSide(color: Color(0xFFEC1313), width: 4))
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tag
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: tagBgColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              tagText,
                              style: GoogleFonts.lexend(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                                color: tagTextColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Title
                          Text(
                            task['title'],
                            style: GoogleFonts.lexend(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: task['status'] == 'completed' 
                                  ? (isDark ? Colors.grey[400] : Colors.grey[600])
                                  : textColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (isCompleted)
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isDark ? successColor.withValues(alpha: 0.3) : const Color(0xFFDCFCE7),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: isDark ? const Color(0xFF4ADE80) : successColor,
                          size: 16,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                // Due date
                Text(
                  task['dueDate'],
                  style: GoogleFonts.lexend(
                    fontSize: 12,
                    color: isUrgent 
                        ? const Color(0xFFEC1313)
                        : (isDark ? Colors.grey[500] : Colors.grey[400]),
                    fontWeight: isUrgent ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                // Status
                _buildTaskStatus(task, isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskStatus(Map<String, dynamic> task, bool isDark) {
    switch (task['status']) {
      case 'submitted':
        return Row(
          children: [
            Text(
              'Submitted',
              style: GoogleFonts.lexend(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDark ? const Color(0xFF4ADE80) : successColor,
              ),
            ),
            const SizedBox(width: 8),
            Text('•', style: TextStyle(color: isDark ? Colors.grey[600] : Colors.grey[300])),
            const SizedBox(width: 8),
            Text(
              'Score: ${task['score']}',
              style: GoogleFonts.lexend(
                fontSize: 10,
                color: isDark ? Colors.grey[500] : Colors.grey[400],
              ),
            ),
          ],
        );
      case 'in_progress':
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF9A3412).withValues(alpha: 0.2) : const Color(0xFFFFF7ED),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'In Progress',
                style: GoogleFonts.lexend(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDark ? const Color(0xFFFB923C) : const Color(0xFFEA580C),
                ),
              ),
            ),
            Text(
              'Submit Now →',
              style: GoogleFonts.lexend(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFEC1313),
              ),
            ),
          ],
        );
      case 'not_started':
        return Text(
          'Not Started',
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey[500] : Colors.grey[500],
          ),
        );
      case 'completed':
        return Text(
          'Completed',
          style: GoogleFonts.lexend(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? const Color(0xFF4ADE80) : successColor,
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_rounded, 'HOME', 0),
              _buildNavItem(Icons.school_rounded, 'KELAS SAYA', 1, isLarge: true),
              _buildNavItem(Icons.notifications_rounded, 'NOTIFIKASI', 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, {bool isLarge = false}) {
    final isSelected = _selectedNavIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedNavIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: isLarge ? 32 : 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: Colors.white,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
