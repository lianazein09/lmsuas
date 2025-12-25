import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialViewerScreen extends StatefulWidget {
  final String title;
  const MaterialViewerScreen({super.key, required this.title});

  @override
  State<MaterialViewerScreen> createState() => _MaterialViewerScreenState();
}

class _MaterialViewerScreenState extends State<MaterialViewerScreen> {
  // Colors from the HTML design
  static const Color primaryColor = Color(0xFFC83439);
  static const Color backgroundLight = Color(0xFFF3F4F6);
  static const Color backgroundDark = Color(0xFF111827);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1F2937);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : const Color(0xFFF3F4F6);
    final headerBg = primaryColor;
    
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: headerBg,
          elevation: 4,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          titleSpacing: 0,
          title: Text(
            widget.title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Text(
                'Halaman 1/26',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildCoverSlide(isDark),
              const SizedBox(height: 16),
              _buildIntroSlide(isDark),
              const SizedBox(height: 16),
              _buildUISlide(isDark),
              const SizedBox(height: 16),
              _buildImportanceSlide(isDark),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  '© 2023 Telkom University',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              const SizedBox(height: 80), // To prevent overlap with FAB
            ],
          ),
          Positioned(
            bottom: 24,
            right: 24,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: primaryColor,
              child: const Icon(Icons.download, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlidePattern() {
    return Opacity(
      opacity: 0.05,
      child: CustomPaint(
        painter: PatternPainter(),
        child: Container(),
      ),
    );
  }

  Widget _buildCoverSlide(bool isDark) {
    return _buildSlideFrame(
      isDark: isDark,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDe9USlqDEIzCTVrYpLKRtNLveDT-EyJDIkfvnZzplOCgs6MncJObSFFY4X7kY-kTzUB8GRKL9g7GjQ_QfZrWvvOfVmS17sxBV2rktAbLAXtEJbKTyIaalMC-RPIcrvnmryXAoQ-7yt3d5isFEBl8a5bjg_sw8tZSJB1BSImkJgt-bZ6UTjeDI7JnU3LrAC_pEs5zHysgVHenX2U-by0uTG6hGJ1vn2mBUzVNrRhoV6nXrQH3DDoojA27cgLZ4hw8pCNRhR2OfEM9ox'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFDC2626), Color(0xFF991B1B)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'U',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'UNIVERSITAS',
                      style: GoogleFonts.inter(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.grey[400] : Colors.grey[500],
                      ),
                    ),
                    Text(
                      'Telkom',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? Colors.black : const Color(0xFF1F2937),
                borderRadius: BorderRadius.circular(8),
                border: const Border(
                  left: BorderSide(color: primaryColor, width: 4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pengantar Desain',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Antarmuka Pengguna',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'VE14',
                          style: GoogleFonts.inter(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFF87171),
                          ),
                        ),
                        Text(
                          'UI / UX Design',
                          style: GoogleFonts.inter(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFF87171),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroSlide(bool isDark) {
    return _buildSlideFrame(
      isDark: isDark,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'Perkenalan',
              style: GoogleFonts.merriweather(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Container(height: 1, color: isDark ? Colors.grey[700] : Colors.grey[200]),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: isDark ? Colors.grey[500]! : Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(46),
                        child: Image.network(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDAV_Iut9p8ErDOsO_4ZP3eWSp5blKr1Yppcr7ZTqTKzGtMDwqJQBiT71KPReZMtMQFm8kunGbJZ2XlS5kCcGseeN21RJ4-jmIIKj73Wo0ZCFfqDCbh1BXh8q7pfoSJgDpnsh9acCi5ghXu5SIyhz4IkKIS6ScfUQ38bSljq1urHCrx1dpmd74pyEh7-j24EA_fbGvbq0RR3vWd2FZRJbAdmMBneWCN222pOEkV3kg24h5FDhMYXsh9KnPQTgBr_51kq6LWlyw7ey7E',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: 104,
                      height: 104,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(Icons.person, 'Ady Purna Kurniawan', 'ADY', isDark),
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.email, 'adypurnakurniawan@telkomuniversity.ac.id', null, isDark),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.school, color: primaryColor, size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bidang Keahlian:',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.grey[200] : Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                _buildSkillPoint('Information System', isDark),
                                _buildSkillPoint('Web Programming and Design', isDark),
                                _buildSkillPoint('Game Development', isDark),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.smartphone, color: primaryColor, size: 16),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '085727930642',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              Text(
                                'SMS/Telp/Whatsapp',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUISlide(bool isDark) {
    return _buildSlideFrame(
      isDark: isDark,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              'User Interface',
              style: GoogleFonts.merriweather(
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 24),
            _buildBulletPoint(
              isDark: isDark,
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.inter(fontSize: 14, height: 1.5, color: isDark ? Colors.grey[300] : Colors.grey[600]),
                  children: [
                    const TextSpan(text: 'Antarmuka/ '),
                    TextSpan(
                      text: 'user interface (UI) ',
                      style: GoogleFonts.inter(fontStyle: FontStyle.italic, color: isDark ? Colors.white : Colors.black),
                    ),
                    const TextSpan(text: 'merupakan bagian dari komputer dan perangkat lunaknya yang dapat '),
                    _buildBoldSpan('dilihat', isDark),
                    const TextSpan(text: ', '),
                    _buildBoldSpan('didengar', isDark),
                    const TextSpan(text: ', '),
                    _buildBoldSpan('disentuh', isDark),
                    const TextSpan(text: ', dan '),
                    _buildBoldSpan('diajak bicara', isDark),
                    const TextSpan(text: ', baik secara langsung maupun dengan proses pemahaman tertentu.'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildBulletPoint(
              isDark: isDark,
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.inter(fontSize: 14, height: 1.5, color: isDark ? Colors.grey[300] : Colors.grey[600]),
                  children: [
                    const TextSpan(text: 'UI yang baik adalah UI yang '),
                    WidgetSpan(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFFFACC15).withOpacity(0.1) : const Color(0xFFFEF9C3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          'tidak disadari',
                          style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: isDark ? const Color(0xFFFACC15) : const Color(0xFF854D0E)),
                        ),
                      ),
                    ),
                    const TextSpan(text: ', dan UI yang memungkinkan pengguna fokus pada informasi dan task tanpa perlu mengetahui mekanisme untuk menampilkan informasi dan melakukan task tersebut.'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildBulletPoint(
              isDark: isDark,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Komponen utamanya:',
                    style: GoogleFonts.inter(fontSize: 14, color: isDark ? Colors.grey[300] : Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  _buildSubPoint('Input', isDark),
                  _buildSubPoint('Output', isDark),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImportanceSlide(bool isDark) {
    return _buildSlideFrame(
      isDark: isDark,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Pentingnya Desain UI yang Baik',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF1F2937),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildBulletPoint(
                  isDark: isDark,
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.inter(fontSize: 14, height: 1.5, color: isDark ? Colors.grey[300] : Colors.grey[600]),
                      children: [
                        const TextSpan(text: 'Banyak sistem dengan fungsionalitas yang baik tapi tidak efisien, membingungkan, dan tidak berguna karena '),
                        _buildBoldSpan('desain UI yang buruk', isDark),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildBulletPoint(
                  isDark: isDark,
                  child: Text(
                    'Antarmuka yang baik merupakan jendela untuk melihat kemampuan sistem serta jembatan bagi kemampuan perangkat lunak.',
                    style: GoogleFonts.inter(fontSize: 14, height: 1.5, color: isDark ? Colors.grey[300] : Colors.grey[600]),
                  ),
                ),
                const SizedBox(height: 16),
                _buildBulletPoint(
                  isDark: isDark,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.inter(fontSize: 14, height: 1.5, color: isDark ? Colors.grey[300] : Colors.grey[600]),
                        children: [
                          const TextSpan(text: 'Desain yang buruk akan '),
                          _buildBoldSpan('membingungkan', isDark),
                          const TextSpan(text: ', '),
                          _buildBoldSpan('tidak efisien', isDark),
                          const TextSpan(text: ', bahkan menyebabkan '),
                          TextSpan(
                            text: 'frustasi',
                            style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: isDark ? const Color(0xFFF87171) : const Color(0xFFDC2626)),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 180,
              height: 120,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(32)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(32)),
                child: Stack(
                  children: [
                    Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDNMfu43WagFOzEu8IaHpO0QMa-xL1sKFZjK4-ckx-5-W7Swv0sAqsX9otACbHy2gP1tWWowe14ZnRCYyFIVVC6RbNeTDkAwPLlV_LCm_JjCZ00KNiynuq-PJI_N4wsm8DnbVLIsvrh__cj1NrBDvI8_yGv1iMaKRyukEl25vynid-HbPx7uZI40I9_E8J_UcoSo6dNhgLXQZLw5bevZVxObvsK-3n-D9YvHGgQHLTuQygE4zYC2w-jkLWMA_EIPHm19NSzfpyVEYZF',
                      fit: BoxFit.cover,
                      width: 180,
                      height: 120,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            (isDark ? surfaceDark : Colors.white).withOpacity(0),
                            isDark ? surfaceDark : Colors.white,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlideFrame({required bool isDark, required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? surfaceDark : surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(child: _buildSlidePattern()),
          child,
        ],
      ),
    );
  }

  TextSpan _buildBoldSpan(String text, bool isDark) {
    return TextSpan(
      text: text,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildBulletPoint({required bool isDark, required Widget child}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('•', style: TextStyle(color: primaryColor, fontSize: 24, height: 1)),
        const SizedBox(width: 8),
        Expanded(child: child),
      ],
    );
  }

  Widget _buildSubPoint(String text, bool isDark) {
    return Row(
      children: [
        Container(width: 8, height: 2, color: Colors.grey[400], margin: const EdgeInsets.only(right: 8)),
        Text(
          text,
          style: GoogleFonts.inter(fontSize: 14, color: isDark ? Colors.grey[400] : Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildSkillPoint(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, String? suffix, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: primaryColor, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.grey[100] : Colors.grey[800],
              ),
              children: [
                TextSpan(text: text),
                if (suffix != null) ...[
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: '→ $suffix',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC83439).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    const spacing = 20.0;
    const radius = 0.5;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
    
    for (double x = spacing / 2; x < size.width; x += spacing) {
      for (double y = spacing / 2; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
