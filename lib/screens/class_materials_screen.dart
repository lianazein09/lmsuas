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
              'Daftar tugas dan kuis akan muncul di sini',
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
