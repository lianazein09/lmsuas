import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedTab = 0;
  int _selectedNavIndex = 0;

  // Colors from the HTML design
  static const Color primaryColor = Color(0xFFA93C3E);
  static const Color logoutColor = Color(0xFFB71C1C);

  // User data (in real app, this would come from an API)
  final Map<String, String> _userData = {
    'name': 'Dandy Candra Pratama',
    'email': 'dandycandra@365.telkomuniversity.ac.id',
    'programStudi': 'D4 Teknologi Rekayasa Multimedia',
    'fakultas': 'FIT',
    'firstAccess': 'Monday, 7 September 2020, 9:27 AM',
    'firstAccessDuration': '288 days 12 hours',
    'lastAccess': 'Tuesday, 22 June 2021, 9:44 PM',
    'lastAccessDuration': 'now',
    'avatarUrl': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBhwFch5-weHfjEreBmpEV-caf5Z7pm6wWssWsZrytfqT9DKQO1X7-znH6C1uLH3D0q_OPuMJqvbkpW3yHmdR7M3ZjSTTWU5oHIuYMV20wM13__rARHav90El-bvveK8FMN3q2FsCRa1FDRN1TW39FpUJODgLBBpgJHFNU8iRoOSHYn1GEgYj82PfsUyCGw1OqSSLa1OoAzfAu6nwnqmhdT_EOqqydG4Ua_zX2EmnwpH76mqTPNcaM6edxRIkIlZ7CrxgAyFAFgTtY',
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              // Header with profile
              _buildHeader(context),
              // Main content
              Expanded(
                child: Transform.translate(
                  offset: const Offset(0, -56),
                  child: _buildMainContent(isDark, cardColor),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 96),
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          // Top bar with back button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                padding: const EdgeInsets.all(8),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                ),
              ),
              const SizedBox(width: 32), // Placeholder for symmetry
            ],
          ),
          const SizedBox(height: 24),
          // Profile picture
          _buildProfilePicture(),
          const SizedBox(height: 16),
          // Name
          Text(
            _userData['name']!.toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Shadow
        Container(
          width: 112,
          height: 112,
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
        ),
        // Profile image
        Container(
          width: 112,
          height: 112,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 4,
            ),
          ),
          child: ClipOval(
            child: Image.network(
              _userData['avatarUrl']!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.person, size: 48, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(bool isDark, Color cardColor) {
    final textSecondaryColor = isDark ? const Color(0xFFA0A0A0) : const Color(0xFF666666);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tab bar
          _buildTabBar(isDark, cardColor),
          const SizedBox(height: 32),
          // Content based on selected tab
          if (_selectedTab == 0) ...[
            _buildAboutMeContent(isDark, textSecondaryColor),
          ] else if (_selectedTab == 1) ...[
            _buildKelasContent(isDark),
          ] else ...[
            _buildEditProfileContent(isDark),
          ],
        ],
      ),
    );
  }

  Widget _buildTabBar(bool isDark, Color cardColor) {
    final tabs = ['About Me', 'Kelas', 'Edit Profile'];

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final label = entry.value;
          final isSelected = _selectedTab == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? (isDark ? Colors.grey[400]! : Colors.grey[600]!)
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? (isDark ? Colors.white : Colors.grey[900])
                        : (isDark ? Colors.grey[400] : Colors.grey[500]),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAboutMeContent(bool isDark, Color textSecondaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User Info Section
        _buildSectionTitle('Informasi User', isDark),
        const SizedBox(height: 16),
        _buildInfoItem('Email address', _userData['email']!, isDark, textSecondaryColor),
        const SizedBox(height: 16),
        _buildInfoItem('Program Studi', _userData['programStudi']!, isDark, textSecondaryColor),
        const SizedBox(height: 16),
        _buildInfoItem('Fakultas', _userData['fakultas']!, isDark, textSecondaryColor),
        
        const SizedBox(height: 32),
        
        // Login Activity Section
        _buildSectionTitle('Aktivitas Login', isDark),
        const SizedBox(height: 16),
        _buildInfoItemWithDuration(
          'First access to site',
          _userData['firstAccess']!,
          _userData['firstAccessDuration']!,
          isDark,
          textSecondaryColor,
        ),
        const SizedBox(height: 20),
        _buildInfoItemWithDuration(
          'Last access to site',
          _userData['lastAccess']!,
          _userData['lastAccessDuration']!,
          isDark,
          textSecondaryColor,
        ),
        
        const SizedBox(height: 32),
        
        // Logout button
        Align(
          alignment: Alignment.centerRight,
          child: _buildLogoutButton(),
        ),
      ],
    );
  }

  Widget _buildKelasContent(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.school_outlined,
              size: 64,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Daftar kelas Anda akan muncul di sini',
              style: GoogleFonts.poppins(
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

  Widget _buildEditProfileContent(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.edit_outlined,
              size: 64,
              color: isDark ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Fitur edit profil akan segera hadir',
              style: GoogleFonts.poppins(
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

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: isDark ? Colors.white : Colors.grey[900],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, bool isDark, Color textSecondaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: textSecondaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey[200] : Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItemWithDuration(
    String label,
    String value,
    String duration,
    bool isDark,
    Color textSecondaryColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: textSecondaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.grey[200] : Colors.grey[800],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '($duration)',
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return ElevatedButton.icon(
      onPressed: () {
        // Handle logout
        _showLogoutDialog();
      },
      icon: const Icon(Icons.logout, size: 20),
      label: Text(
        'Log Out',
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: logoutColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Konfirmasi Logout',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Apakah Anda yakin ingin keluar?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Batal',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to login screen
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(backgroundColor: logoutColor),
            child: Text(
              'Logout',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', 0),
              _buildNavItem(Icons.school, 'Kelas Saya', 1),
              _buildNavItem(Icons.notifications, 'Notifikasi', 2),
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
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              )
            else
              Icon(
                icon,
                color: Colors.white.withValues(alpha: 0.7),
                size: 24,
              ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
