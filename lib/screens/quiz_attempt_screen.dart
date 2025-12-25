import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizAttemptScreen extends StatefulWidget {
  final String title;
  const QuizAttemptScreen({super.key, required this.title});

  @override
  State<QuizAttemptScreen> createState() => _QuizAttemptScreenState();
}

class _QuizAttemptScreenState extends State<QuizAttemptScreen> {
  static const Color primaryColor = Color(0xFFC05052);
  static const Color primaryLight = Color(0xFFE86A6C);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFFF5F5F5);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  int currentQuestion = 1;
  String? selectedOption = 'A';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? backgroundDark : backgroundLight;
    final textColor = isDark ? const Color(0xFFE5E5E5) : const Color(0xFF333333);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          padding: const EdgeInsets.only(top: 40, bottom: 8, left: 24, right: 24),
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
          child: Row(
            children: [
              const Expanded(child: SizedBox()),
              Text(
                widget.title,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.timer_outlined, color: Colors.white, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      '15 : 00',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuestionGrid(isDark),
                  const SizedBox(height: 32),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      children: [
                        TextSpan(text: 'Soal Nomor $currentQuestion '),
                        TextSpan(
                          text: '/ 15',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: isDark ? Colors.grey[400] : Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Radio button dapat digunakan untuk menentukan ?',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDark ? const Color(0xFFE5E5E5) : const Color(0xFF111827),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildOption('A', 'Jenis Kelamin', isDark),
                  _buildOption('B', 'Alamat', isDark),
                  _buildOption('C', 'Hobby', isDark),
                  _buildOption('D', 'Riwayat Pendidikan', isDark),
                  _buildOption('E', 'Umur', isDark),
                  const SizedBox(height: 32),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? surfaceDark : surfaceLight,
                        foregroundColor: isDark ? Colors.white : const Color(0xFF1F2937),
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Soal Selanjutnya nya.',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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

  Widget _buildQuestionGrid(bool isDark) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: List.generate(10, (index) => _buildGridItem(index + 1, isDark)),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: List.generate(5, (index) => _buildGridItem(index + 11, isDark)),
        ),
      ],
    );
  }

  Widget _buildGridItem(int number, bool isDark) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isDark ? surfaceDark : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: isDark ? Colors.grey[700]! : Colors.grey[400]!,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          '$number',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black,
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
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? primaryLight : (isDark ? surfaceDark : surfaceLight),
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected 
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ] : null,
            border: isSelected 
              ? Border.all(color: primaryLight, width: 2) 
              : null,
          ),
          child: Row(
            children: [
              Text(
                '$letter.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.black : (isDark ? Colors.grey[400] : Colors.grey[500]),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.black : (isDark ? const Color(0xFFE5E5E5) : const Color(0xFF1F2937)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
