import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizQuestionReviewDetailScreen extends StatelessWidget {
  final int questionNumber;
  final String question;
  final String selectedAnswer;
  
  const QuizQuestionReviewDetailScreen({
    super.key, 
    required this.questionNumber,
    required this.question,
    required this.selectedAnswer,
  });

  static const Color primaryColor = Color(0xFFBE4B4A);
  static const Color quizGreen = Color(0xFF4ADE3B);
  static const Color selectedRed = Color(0xFFEF696C);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color optionBgLight = Color(0xFFF5F5F5);
  static const Color optionBgDark = Color(0xFF2C2C2C);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? backgroundDark : backgroundLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 4,
        automaticallyImplyLeading: false,
        title: Text(
          'Quiz Review 1',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                const Icon(Icons.timer_rounded, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  '15 : 00',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: List.generate(15, (index) => _buildBubble(index + 1)),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Soal Nomor $questionNumber / 15',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      question,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.grey[200] : Colors.grey[800],
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  _buildOption('A', 'Jenis Kelamin', isDark),
                  _buildOption('B', 'Alamat', isDark),
                  _buildOption('C', 'Hobby', isDark),
                  _buildOption('D', 'Riwayat Pendidikan', isDark),
                  _buildOption('E', 'Umur', isDark),
                  const SizedBox(height: 40),
                  Center(
                    child: SizedBox(
                      width: 220,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? optionBgDark : optionBgLight,
                          foregroundColor: isDark ? Colors.white : const Color(0xFF374151),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Kembali Ke Halaman Review',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
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

  Widget _buildBubble(int number) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: quizGreen,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF16A34A), width: 1),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Center(
        child: Text(
          '$number',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildOption(String letter, String text, bool isDark) {
    final bool isSelected = selectedAnswer.startsWith(letter);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected 
              ? (isDark ? const Color(0xFFB91C1C) : selectedRed)
              : (isDark ? optionBgDark : optionBgLight),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Text(
              '$letter.',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : (isDark ? Colors.grey[400] : Colors.grey[700]),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : (isDark ? Colors.grey[100] : Colors.grey[900]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
