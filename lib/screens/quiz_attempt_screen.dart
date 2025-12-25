import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizAttemptScreen extends StatefulWidget {
  final String title;
  const QuizAttemptScreen({super.key, required this.title});

  @override
  State<QuizAttemptScreen> createState() => _QuizAttemptScreenState();
}

class _QuizAttemptScreenState extends State<QuizAttemptScreen> {
  static const Color primaryColor = Color(0xFFB94A48);
  static const Color secondaryColor = Color(0xFFED6A6A);
  static const Color successColor = Color(0xFF4CD964);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFFF6F6F6);
  static const Color surfaceDark = Color(0xFF2A2A2A);

  int currentQuestion = 2;
  String? selectedOption = 'C';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? backgroundDark : backgroundLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          padding: const EdgeInsets.only(top: 30, bottom: 8, left: 24, right: 24),
          decoration: const BoxDecoration(
            color: primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              Positioned(
                right: 0,
                child: Row(
                  children: [
                    const Icon(Icons.timer_rounded, color: Colors.white, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      '15 : 00',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuestionGrid(isDark),
                  const SizedBox(height: 32),
                  Text(
                    'Soal Nomor $currentQuestion / 15',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu ?',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: isDark ? const Color(0xFFD1D1D1) : const Color(0xFF1F2937),
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildOption('A', 'Intergrasi', isDark),
                  _buildOption('B', 'Standarisasi', isDark),
                  _buildOption('C', 'Konsistensi', isDark),
                  _buildOption('D', 'Koefensi', isDark),
                  _buildOption('E', 'Koreksi', isDark),
                  const SizedBox(height: 48),
                  Row(
                    gap: 16,
                    children: [
                      Expanded(
                        child: _buildNavButton('Soal Sebelum nya.', isDark),
                      ),
                      Expanded(
                        child: _buildNavButton('Soal Selanjut nya.', isDark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionGrid(bool isDark) {
    return Column(
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: List.generate(10, (index) => _buildGridItem(index + 1, isDark)),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: List.generate(5, (index) => _buildGridItem(index + 11, isDark)),
        ),
      ],
    );
  }

  Widget _buildGridItem(int number, bool isDark) {
    final bool isCompleted = number == 1; // Match HTML where 1 is success
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isCompleted ? successColor : (isDark ? surfaceDark : Colors.white),
        shape: BoxShape.circle,
        boxShadow: isCompleted ? [const BoxShadow(color: Colors.black12, blurRadius: 4)] : null,
        border: !isCompleted ? Border.all(
          color: isDark ? const Color(0xFF404040) : const Color(0xFF9CA3AF),
          width: 1,
        ) : null,
      ),
      child: Center(
        child: Text(
          '$number',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: isCompleted ? FontWeight.bold : FontWeight.w500,
            color: isCompleted ? Colors.white : (isDark ? const Color(0xFFE5E7EB) : const Color(0xFF374151)),
          ),
        ),
      ),
    );
  }

  Widget _buildOption(String letter, String text, bool isDark) {
    final isSelected = selectedOption == letter;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () => setState(() => selectedOption = letter),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isSelected ? secondaryColor : (isDark ? surfaceDark : surfaceLight),
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected ? [const BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))] : null,
            border: isSelected ? Border.all(color: secondaryColor.withOpacity(0.5), width: 2) : null,
          ),
          child: Transform.scale(
            scale: isSelected ? 1.02 : 1.0,
            child: Row(
              children: [
                Text(
                  '$letter.   ',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.black : (isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937)),
                  ),
                ),
                Expanded(
                  child: Text(
                    text,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.black : (isDark ? const Color(0xFFD1D1D1) : const Color(0xFF1F2937)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(String label, bool isDark) {
    return Container(
      height: 48,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? surfaceDark : surfaceLight,
          foregroundColor: isDark ? Colors.white : const Color(0xFF1F2937),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
