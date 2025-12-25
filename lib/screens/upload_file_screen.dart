import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadFileScreen extends StatelessWidget {
  const UploadFileScreen({super.key});

  static const Color primaryColor = Color(0xFFB04141);
  static const Color cloudBlue = Color(0xFF3498DB);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF18181B);
  static const Color surfaceLight = Color(0xFFF5F5F5);
  static const Color surfaceDark = Color(0xFF27272A);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? backgroundDark : backgroundLight;
    final textColor = isDark ? const Color(0xFFD1D5DB) : const Color(0xFF374151);

    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 16, bottom: 32),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                // Notch/Handle
                Container(
                  width: 64,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Upload File',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  Text(
                    'Maksimum File 5MB , Maksimum Jumlah File 20',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Upload Area
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1F2937) : Colors.white,
                        border: Border.all(
                          color: isDark ? Colors.grey[600]! : Colors.black,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: CustomPaint(
                        painter: DashedBorderPainter(
                          color: isDark ? Colors.grey[500]! : Colors.grey[400]!,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.cloud_upload_outlined,
                              size: 80,
                              color: cloudBlue,
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'File yang akan di upload akan tampil di sini',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Action Buttons
                  _buildActionButton('Pilih File', isDark),
                  const SizedBox(height: 16),
                  _buildActionButton('Simpan', isDark),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, bool isDark) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? surfaceDark : surfaceLight,
          foregroundColor: isDark ? Colors.white : Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  DashedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const dashWidth = 5;
    const dashSpace = 3;

    // Draw dashed lines for each side
    void drawDashedLine(Offset start, Offset end) {
      double currentPosition = 0;
      final distance = (end - start).distance;
      final unitVector = (end - start) / distance;

      while (currentPosition < distance) {
        canvas.drawLine(
          start + unitVector * currentPosition,
          start + unitVector * (currentPosition + dashWidth > distance ? distance : currentPosition + dashWidth),
          paint,
        );
        currentPosition += dashWidth + dashSpace;
      }
    }

    drawDashedLine(Offset.zero, Offset(size.width, 0)); // Top
    drawDashedLine(Offset(size.width, 0), Offset(size.width, size.height)); // Right
    drawDashedLine(Offset(size.width, size.height), Offset(0, size.height)); // Bottom
    drawDashedLine(Offset(0, size.height), Offset.zero); // Left
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
