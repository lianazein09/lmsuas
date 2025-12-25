import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizReviewScreen extends StatelessWidget {
  final String title;
  const QuizReviewScreen({super.key, required this.title});

  static const Color primaryColor = Color(0xFFC94E4E);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF18181B);
  static const Color surfaceLight = Color(0xFFF8F9FA);
  static const Color surfaceDark = Color(0xFF27272A);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? backgroundDark : backgroundLight;
    final textColor = isDark ? const Color(0xFFE4E4E7) : const Color(0xFF333333);
    final secondaryTextColor = isDark ? const Color(0xFFA1A1AA) : const Color(0xFF6B7280);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 4,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInstructions(textColor),
            const SizedBox(height: 24),
            _buildSummaryBox(isDark, textColor),
            const SizedBox(height: 24),
            _buildAttemptsSection(isDark, textColor, secondaryTextColor),
            const SizedBox(height: 16),
            Text(
              'Nilai Akhir Anda Untuk Kuis Ini Adalah 85.0 / 100.00',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 32),
            _buildActionButton('Ambil Kuis', isDark),
            const SizedBox(height: 12),
            _buildActionButton('Kembali Ke Kelas', isDark),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructions(Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Silahkan kerjakan kuis ini dalam waktu 15 menit sebagai nilai pertama komponen kuis. Jangan lupa klik tombol Submit Answer setelah menjawab seluruh pertanyaan.',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: textColor,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Kerjakan sebelum hari Jum'at, 26 Februari 2021 jam 23:59 WIB.",
          style: GoogleFonts.inter(
            fontSize: 14,
            color: textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryBox(bool isDark, Color textColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? surfaceDark : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF3F3F46) : const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Kuis Akan di tutup pada Jumat, 26 February 2021, 11:59 PM',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Batas Waktu: 15 menit',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Metode Penilaian: Nilai Tertinggi',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttemptsSection(bool isDark, Color textColor, Color secondaryTextColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Percobaan Yang Sudah Di Lakukan',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDark ? const Color(0xFF3F3F46) : const Color(0xFFE5E7EB),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                color: primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Status',
                        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Nilai / 100.00',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Tinjau Kembali',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: isDark ? const Color(0xFF18181B) : surfaceLight,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selesai',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Dikirim Pada Kamis, 25 Februari 2021, 10:40',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: secondaryTextColor,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          '85,0',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Lihat',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue[500],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, bool isDark) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? surfaceDark : const Color(0xFFF3F4F6),
          foregroundColor: isDark ? Colors.white : const Color(0xFF1F2937),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
