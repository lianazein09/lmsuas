import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();

  /// Show the help screen as a modal bottom sheet
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const HelpScreen(),
    );
  }
}

class _HelpScreenState extends State<HelpScreen> {
  bool _isIndonesian = true;

  // Colors from the HTML design
  static const Color primaryColor = Color(0xFFB91C1C);
  static const Color surfaceLight = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1F2937) : surfaceLight;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          _buildDragHandle(isDark),
          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Language selector
                  _buildLanguageSelector(isDark),
                  const SizedBox(height: 32),
                  // Info banner
                  _buildInfoBanner(isDark),
                  const SizedBox(height: 24),
                  // Login instructions
                  _buildLoginInstructions(isDark),
                  const SizedBox(height: 24),
                  // Warning banner
                  _buildWarningBanner(isDark),
                  const SizedBox(height: 24),
                  // Divider
                  Divider(
                    color: isDark ? Colors.grey[700] : Colors.grey[200],
                  ),
                  const SizedBox(height: 24),
                  // Helpdesk section
                  _buildHelpdeskSection(isDark),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragHandle(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        width: 64,
        height: 6,
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[600] : Colors.grey[300],
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(bool isDark) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Indonesian flag
          _buildLanguageButton(
            isSelected: _isIndonesian,
            flagUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBLHBxa1ICkuVNOFHnkTPz_9o2B5nVMsPtbpbdxLyngkMD7NjN94e8FEJmtSo5PhHuwbTwbG7UhenunnNeriZGfcKC91WWycH5000bbXPsF7r21pVzPD4mWNVgZvl4TCXfJG-K2lxnYElW1r9I45LJetgF0y6BgMRXIJP0JFmJ-2PvOXI2CB7OIOrQXnEitbZ3sarQuLNHGJHnnamVFmASDt3mM0PcZ7aSFPkRcIFmSfb0kZPwgMn0vwsBBkSpk1vfAozqG9L6EdgA',
            label: 'ID',
            onTap: () => setState(() => _isIndonesian = true),
            isDark: isDark,
          ),
          const SizedBox(width: 48),
          // English flag
          _buildLanguageButton(
            isSelected: !_isIndonesian,
            flagUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCEzfnyTav-FsKBGJ_GVsEVsUxJnMoKlFOoNwiYat-JPKvFGY83BVkAfEmWaE1nNTbFz7APOz937p_pKGpU5xDdkJh2ti9f8aSY5qNYi04CgxE5mSikiZ7EjTKr0VCV0OEx_RIzXdgUJjrn2NkJscxLoYgP1UzCygZz3o4kBkZ38KNGOBPAQVtwm9aXlE2bGLP99CdS3o1PFura062Q_b0pFp_kufPPM41PCAN2ML57iXjnHIEkT72J9_gSBrsbtijdAx4OJmA8Is8',
            label: 'EN',
            onTap: () => setState(() => _isIndonesian = false),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageButton({
    required bool isSelected,
    required String flagUrl,
    required String label,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isSelected ? 1.0 : 0.4,
        child: Column(
          children: [
            Container(
              width: isSelected ? 40 : 32,
              height: isSelected ? 28 : 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: isSelected
                    ? Border.all(color: primaryColor, width: 2)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.network(
                  flagUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.flag, size: 16, color: Colors.grey[600]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: isSelected ? 14 : 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
                color: isSelected
                    ? primaryColor
                    : (isDark ? Colors.grey[400] : Colors.grey[500]),
              ),
            ),
            if (isSelected) ...[
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBanner(bool isDark) {
    final infoText = _isIndonesian
        ? 'Akses terbatas hanya untuk Dosen dan Mahasiswa Telkom University.'
        : 'Access is restricted to Telkom University lecturers and students only.';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E3A5F).withValues(alpha: 0.3)
            : const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? const Color(0xFF1E40AF).withValues(alpha: 0.3)
              : const Color(0xFFDBEAFE),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_rounded,
            color: isDark ? const Color(0xFF60A5FA) : const Color(0xFF2563EB),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              infoText,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark
                    ? const Color(0xFFBFDBFE)
                    : const Color(0xFF1E40AF),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginInstructions(bool isDark) {
    final titleText = _isIndonesian ? 'Petunjuk Login' : 'Login Instructions';
    final descText = _isIndonesian
        ? 'Login menggunakan Akun Microsoft Office 365 mengikuti format ini:'
        : 'Login using your Microsoft Office 365 account with this format:';
    final usernameLabel = _isIndonesian ? 'Nama Pengguna' : 'Username';
    final usernameDesc = _isIndonesian
        ? '(Akun iGracias) diikuti dengan'
        : '(iGracias Account) followed by';
    final passwordLabel = _isIndonesian ? 'Kata Sandi' : 'Password';
    final passwordDesc = _isIndonesian
        ? 'Kata Sandi iGracias.'
        : 'iGracias Password.';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.login_rounded, color: primaryColor, size: 16),
            const SizedBox(width: 8),
            Text(
              titleText.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: isDark ? Colors.white : Colors.grey[900],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          descText,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: isDark ? Colors.grey[300] : Colors.grey[600],
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        // Username instruction
        _buildInstructionItem(
          label: usernameLabel,
          content: usernameDesc,
          suffix: '@365.telkomuniversity.ac.id',
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        // Password instruction
        _buildInstructionItem(
          label: passwordLabel,
          content: passwordDesc,
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildInstructionItem({
    required String label,
    required String content,
    String? suffix,
    required bool isDark,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[700] : Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: isDark ? Colors.grey[400] : Colors.grey[500],
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    content,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: isDark ? Colors.grey[200] : Colors.grey[800],
                    ),
                  ),
                  if (suffix != null) ...[
                    const SizedBox(width: 4),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
                        ),
                      ),
                      child: Text(
                        suffix,
                        style: GoogleFonts.robotoMono(
                          fontSize: 11,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWarningBanner(bool isDark) {
    final titleText = _isIndonesian ? 'Gagal Autentikasi?' : 'Authentication Failed?';
    final descText = _isIndonesian
        ? 'Mungkin Anda belum memiliki "Kata Sandi Kuat". Pastikan untuk mengubah kata sandi Anda hanya di iGracias.'
        : 'You may not have a "Strong Password" yet. Make sure to change your password only on iGracias.';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF7C2D12).withValues(alpha: 0.2)
            : const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? const Color(0xFF9A3412).withValues(alpha: 0.3)
              : const Color(0xFFFED7AA),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_rounded,
                color: isDark
                    ? const Color(0xFFFB923C)
                    : const Color(0xFFC2410C),
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                titleText.toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: isDark
                      ? const Color(0xFFFB923C)
                      : const Color(0xFFC2410C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            descText,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: isDark
                  ? const Color(0xFFFED7AA).withValues(alpha: 0.8)
                  : const Color(0xFF7C2D12),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpdeskSection(bool isDark) {
    final titleText = _isIndonesian ? 'Helpdesk CeLOe' : 'CeLOe Helpdesk';
    final emailLabel = _isIndonesian ? 'Dukungan Email' : 'Email Support';
    final whatsappLabel = _isIndonesian ? 'Dukungan WhatsApp' : 'WhatsApp Support';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: isDark ? Colors.grey[400] : Colors.grey[500],
          ),
        ),
        const SizedBox(height: 16),
        // Email contact
        _buildContactCard(
          icon: Icons.mail_rounded,
          label: emailLabel,
          value: 'infoceloe@telkomuniversity.ac.id',
          hoverColor: primaryColor.withValues(alpha: 0.1),
          iconHoverColor: primaryColor,
          valueHoverColor: primaryColor,
          onTap: () => _launchUrl('mailto:infoceloe@telkomuniversity.ac.id'),
          isDark: isDark,
        ),
        const SizedBox(height: 12),
        // WhatsApp contact
        _buildContactCard(
          icon: Icons.chat_rounded,
          label: whatsappLabel,
          value: '+62 821-1666-3563',
          hoverColor: const Color(0xFF22C55E).withValues(alpha: 0.1),
          iconHoverColor: const Color(0xFF22C55E),
          valueHoverColor: const Color(0xFF15803D),
          onTap: () => _launchUrl('https://wa.me/6282116663563'),
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String label,
    required String value,
    required Color hoverColor,
    required Color iconHoverColor,
    required Color valueHoverColor,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Material(
      color: isDark ? Colors.grey[800] : Colors.grey[50],
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        hoverColor: hoverColor,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[700] : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: isDark ? Colors.grey[400] : Colors.grey[500],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: isDark ? Colors.grey[500] : Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.grey[200] : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
