import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  static const Color backgroundLight = Color(0xFFC0494A);
  static const Color backgroundDark = Color(0xFF8B3031);

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Navigate to login screen after 3 seconds
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? backgroundDark : backgroundLight;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: bgColor,
        child: Center(
          child: ScaleTransition(
            scale: _pulseAnimation,
            child: FadeTransition(
              opacity: _pulseAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'LEARNING MANAGEMENT SYSTEM',
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.0,
                        shadows: [
                          const Shadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      width: 280,
      height: 105,
      child: CustomPaint(
        painter: LmsLogoPainter(),
      ),
    );
  }
}

class LmsLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14 // Relative to viewBox 400x150
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    double scale = size.width / 400;
    canvas.save();
    canvas.scale(scale);

    // C
    Path cPath = Path();
    cPath.moveTo(70, 100);
    cPath.cubicTo(40, 100, 20, 80, 20, 60);
    cPath.cubicTo(20, 40, 40, 20, 70, 20);
    cPath.lineTo(90, 20);
    canvas.drawPath(cPath, paint);

    // e (1)
    Path e1Path = Path();
    e1Path.moveTo(120, 60);
    e1Path.cubicTo(110, 40, 130, 20, 150, 20);
    e1Path.cubicTo(170, 20, 180, 40, 180, 50);
    e1Path.cubicTo(180, 70, 120, 70, 120, 70);
    e1Path.cubicTo(120, 90, 140, 100, 160, 100);
    canvas.drawPath(e1Path, paint);

    // L
    Path lPath = Path();
    lPath.moveTo(190, 20);
    lPath.lineTo(190, 80);
    lPath.cubicTo(190, 95, 210, 100, 220, 90);
    lPath.lineTo(240, 60);
    canvas.drawPath(lPath, paint);

    // O
    canvas.drawCircle(const Offset(270, 70), 30, paint);

    // Hat
    Path hatPath = Path();
    hatPath.moveTo(240, 10);
    hatPath.lineTo(290, 15);
    hatPath.lineTo(340, 10);
    canvas.drawPath(hatPath, paint);

    // e (2)
    Path e2Path = Path();
    e2Path.moveTo(330, 60);
    e2Path.cubicTo(320, 40, 340, 20, 360, 20);
    e2Path.cubicTo(380, 20, 390, 40, 390, 50);
    e2Path.cubicTo(390, 70, 330, 70, 330, 70);
    e2Path.cubicTo(330, 90, 350, 100, 370, 100);
    canvas.drawPath(e2Path, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
