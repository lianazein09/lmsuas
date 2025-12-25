import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'quiz_review_answer_screen.dart';

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

  int currentIndex = 1; // Current displayed question index (0-14)
  final Map<int, String?> _selectedAnswers = {0: 'A', 1: 'C'}; // Mock pre-selected answers

  final List<String> _questions = [
    'Radio button dapat digunakan untuk menentukan ?',
    'Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu ?',
    'Apa fungsi utama dari User Experience (UX) design dalam pengembangan aplikasi?',
    'Elemen visual manakah yang paling efektif untuk mengarahkan pandangan pengguna ke tombol CTA?',
    'Prinsip "Affordance" dalam desain antarmuka merujuk pada?',
    'Manakah dari berikut ini yang merupakan contoh dari "Dark Pattern" dalam desain UI?',
    'Grid system dalam desain tata letak berfungsi untuk?',
    'Apa yang dimaksud dengan "Responsive Design"?',
    'Warna "Primary" dalam sebuah design system biasanya digunakan untuk?',
    'Istilah "Whitespace" dalam desain antarmuka merujuk pada?',
    'Fitts\'s Law dalam desain interaksi berkaitan dengan?',
    'Apa kegunaan utama dari Wireframe dalam fase desain?',
    'Manakah tipe navigasi yang paling umum untuk aplikasi mobile dengan banyak kategori?',
    'Heuristic Evaluation adalah metode untuk?',
    'Apa perbedaan utama antara UI dan UX?',
  ];

  final List<List<String>> _options = [
    ['Jenis Kelamin', 'Alamat', 'Hobby', 'Riwayat Pendidikan', 'Umur'],
    ['Intergrasi', 'Standarisasi', 'Konsistensi', 'Koefensi', 'Koreksi'],
    ['Memperindah tampilan', 'Memastikan kemudahan penggunaan', 'Menambah fitur', 'Mempercepat coding', 'Mengurangi biaya'],
    ['Warna kontras', 'Ukuran font kecil', 'Garis tipis', 'Warna pastel', 'Background transparan'],
    ['Kecantikan visual', 'Petunjuk penggunaan objek', 'Kecepatan loading', 'Kapasitas storage', 'Harga aplikasi'],
    ['Konfirmasi pembatalan', 'Notifikasi pembaruan', 'Biaya tersembunyi saat checkout', 'Panduan tutorial', 'Search bar'],
    ['Menghemat memori', 'Menjaga keteraturan tata letak', 'Mempercepat render', 'Enkripsi data', 'Kompres gambar'],
    ['Desain yang cepat', 'Desain yang menyesuaikan ukuran layar', 'Desain dengan banyak animasi', 'Desain yang murah', 'Desain tanpa gambar'],
    ['Teks biasa', 'Elemen terpenting/utama', 'Background halaman', 'Border tipis', 'Logo perusahaan'],
    ['Area tanpa konten', 'Warna putih saja', 'Latar belakang gambar', 'Teks berwarna putih', 'Margin luar'],
    ['Waktu untuk mencapai target', 'Warna yang serasi', 'Ukuran gambar video', 'Jumlah klik menu', 'Keamanan password'],
    ['Implementasi backend', 'Visual awal struktur halaman', 'Testing database', 'Publish ke store', 'Membuat animasi'],
    ['Sidebar', 'Burger menu', 'Bottom navigation bar', 'Scroll horizontal', 'Tab bar'],
    ['Menghitung biaya', 'Memeriksa usability berdasarkan aturan', 'Mencari bug kode', 'Menambah server', 'Membuat iklan'],
    ['UI adalah rasa, UX adalah rupa', 'UI adalah rupa, UX adalah rasa', 'Tidak ada perbedaan', 'UI lebih penting', 'UX hanya untuk web'],
  ];

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
                    'Soal Nomor ${currentIndex + 1} / 15',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _questions[currentIndex],
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: isDark ? const Color(0xFFD1D1D1) : const Color(0xFF1F2937),
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ...List.generate(5, (index) {
                    final letter = String.fromCharCode(65 + index);
                    return _buildOption(letter, _options[currentIndex][index], isDark);
                  }),
                  const SizedBox(height: 48),
                  Row(
                    children: [
                      if (currentIndex > 0)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: _buildNavButton('Soal Sebelum nya.', isDark, () {
                              setState(() => currentIndex--);
                            }),
                          ),
                        ),
                      Expanded(
                        child: _buildNavButton(
                          currentIndex < 14 ? 'Soal Selanjut nya.' : 'Selesai & Review',
                          isDark,
                          () {
                            if (currentIndex < 14) {
                              setState(() => currentIndex++);
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const QuizReviewAnswerScreen(),
                                ),
                              );
                            }
                          },
                        ),
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
    final int index = number - 1;
    final bool isCompleted = _selectedAnswers.containsKey(index);
    final bool isCurrent = currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => currentIndex = index),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isCompleted ? successColor : (isDark ? surfaceDark : Colors.white),
          shape: BoxShape.circle,
          boxShadow: isCompleted || isCurrent ? [const BoxShadow(color: Colors.black12, blurRadius: 4)] : null,
          border: Border.all(
            color: isCurrent 
                ? (isDark ? Colors.white : primaryColor)
                : (isCompleted ? Colors.transparent : (isDark ? const Color(0xFF404040) : const Color(0xFF9CA3AF))),
            width: isCurrent ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            '$number',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: (isCompleted || isCurrent) ? FontWeight.bold : FontWeight.w500,
              color: isCompleted ? Colors.white : (isDark ? const Color(0xFFE5E7EB) : const Color(0xFF374151)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOption(String letter, String text, bool isDark) {
    final isSelected = _selectedAnswers[currentIndex] == letter;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () => setState(() => _selectedAnswers[currentIndex] = letter),
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

  Widget _buildNavButton(String label, bool isDark, VoidCallback onTap) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: onTap,
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
