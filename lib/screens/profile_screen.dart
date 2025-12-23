import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'notification_screen.dart';
import 'class_materials_screen.dart';

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

  // Accent blue color from HTML design
  static const Color accentBlue = Color(0xFF85B6D9);

  // Class list data
  final List<Map<String, String>> _classList = [
    {
      'title': 'Bahasa Inggris: Business and Scientific',
      'code': 'D4SM-41-GAB1 [ARS]',
      'date': 'Tanggal Mulai Monday, 8 February 2021',
    },
    {
      'title': 'Desain Antarmuka & Pengalaman Pengguna',
      'code': 'D4SM-42-03 [ADY]',
      'date': 'Tanggal Mulai Monday, 8 February 2021',
    },
    {
      'title': 'Kewarganegaraan',
      'code': 'D4SM-41-GAB1 [BBO]. JUMAT 2',
      'date': 'Tanggal Mulai Monday, 8 February 2021',
    },
    {
      'title': 'Olah Raga D3TT-44-02 [EYR]',
      'code': '',
      'date': 'Tanggal Mulai Monday, 8 February 2021',
    },
    {
      'title': 'Pemrograman Multimedia Interaktif',
      'code': 'D4SM-43-04 [TPR]',
      'date': 'Tanggal Mulai Monday, 8 February 2021',
    },
    {
      'title': 'Pemrograman Perangkat Bergerak Multimedia',
      'code': 'D4SM-41-GAB1 [APJ]',
      'date': 'Tanggal Mulai Monday, 8 February 2021',
    },
    {
      'title': 'Sistem Operasi D4SM-44-02 [DDS]',
      'code': '',
      'date': 'Tanggal Mulai Monday, 8 February 2021',
    },
  ];

  Widget _buildKelasContent(bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _classList.length,
      itemBuilder: (context, index) {
        final classItem = _classList[index];
        return _buildClassItem(classItem, isDark);
      },
    );
  }

  Widget _buildClassItem(Map<String, String> classItem, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Blue rectangle icon
          Container(
            width: 64,
            height: 48,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: accentBlue,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Class info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  classItem['title']!.toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.grey[900],
                    height: 1.3,
                  ),
                ),
                if (classItem['code']!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    classItem['code']!,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: isDark ? Colors.grey[300] : Colors.grey[600],
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  classItem['date']!,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: isDark ? Colors.grey[400] : Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Text controllers for edit profile form
  final _firstNameController = TextEditingController(text: 'Dandy');
  final _lastNameController = TextEditingController(text: 'Candra Pratama');
  final _emailEditController = TextEditingController(text: 'dandy.cp@example.com');
  final _countryController = TextEditingController(text: 'Indonesia');
  final _descriptionController = TextEditingController();

  Widget _buildEditProfileContent(bool isDark) {
    final cardColor = isDark ? const Color(0xFF27272A) : Colors.white;
    final borderColor = isDark ? const Color(0xFF52525B) : const Color(0xFF9CA3AF);
    final labelColor = isDark ? Colors.grey[300] : Colors.grey[700];
    final inputTextColor = isDark ? Colors.white : Colors.grey[900];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nama Pertama
          _buildFormField(
            label: 'Nama Pertama',
            controller: _firstNameController,
            placeholder: 'Dandy',
            isDark: isDark,
            cardColor: cardColor,
            borderColor: borderColor,
            labelColor: labelColor!,
            inputTextColor: inputTextColor!,
          ),
          const SizedBox(height: 20),
          // Nama Terakhir
          _buildFormField(
            label: 'Nama Terakhir',
            controller: _lastNameController,
            placeholder: 'Candra Pratama',
            isDark: isDark,
            cardColor: cardColor,
            borderColor: borderColor,
            labelColor: labelColor,
            inputTextColor: inputTextColor,
          ),
          const SizedBox(height: 20),
          // E-mail Address
          _buildFormField(
            label: 'E-mail Address',
            controller: _emailEditController,
            placeholder: 'dandy.cp@example.com',
            isDark: isDark,
            cardColor: cardColor,
            borderColor: borderColor,
            labelColor: labelColor,
            inputTextColor: inputTextColor,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          // Negara
          _buildFormField(
            label: 'Negara',
            controller: _countryController,
            placeholder: 'Indonesia',
            isDark: isDark,
            cardColor: cardColor,
            borderColor: borderColor,
            labelColor: labelColor,
            inputTextColor: inputTextColor,
          ),
          const SizedBox(height: 20),
          // Deskripsi
          _buildFormField(
            label: 'Deskripsi',
            controller: _descriptionController,
            placeholder: 'Tulis deskripsi diri anda...',
            isDark: isDark,
            cardColor: cardColor,
            borderColor: borderColor,
            labelColor: labelColor,
            inputTextColor: inputTextColor,
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          // Simpan button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // Handle save
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Profil berhasil disimpan!',
                      style: GoogleFonts.poppins(),
                    ),
                    backgroundColor: primaryColor,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? const Color(0xFF27272A) : const Color(0xFFF3F4F6),
                foregroundColor: isDark ? Colors.white : Colors.grey[900],
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              child: Text(
                'Simpan',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String placeholder,
    required bool isDark,
    required Color cardColor,
    required Color borderColor,
    required Color labelColor,
    required Color inputTextColor,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: inputTextColor,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              color: isDark ? Colors.grey[500] : Colors.grey[400],
            ),
            filled: true,
            fillColor: cardColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: primaryColor, width: 2),
            ),
          ),
        ),
      ],
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
      onTap: () {
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NotificationScreen()),
          );
        }
      },
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
