import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Primary color sampled from the red background
  static const Color primaryColor = Color(0xFFB84A4B);

  @override
  void initState() {
    super.initState();

    // Fade-in animation for logo (1.2s duration)
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    // Slide-up animation for text (0.8s duration, 0.5s delay)
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));

    // Pulse animation for loading dots (3s infinite)
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();

    // Start animations
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _slideController.forward();
    });

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
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: primaryColor,
        ),
        child: Stack(
          children: [
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.1),
                  ],
                ),
              ),
            ),
            // Main content
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo with fade-in animation
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildLogo(),
                    ),
                    const SizedBox(height: 24),
                    // Text with slide-up animation
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _slideController,
                        child: Text(
                          'Learning Management System',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Loading dots at bottom
            Positioned(
              bottom: 48,
              left: 0,
              right: 0,
              child: ListenableBuilder(
                listenable: _pulseController,
                builder: (context, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildDot(0.4),
                      const SizedBox(width: 8),
                      _buildDot(0.7),
                      const SizedBox(width: 8),
                      _buildDot(0.4),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      width: 200,
      height: 80,
      child: CustomPaint(
        painter: LmsLogoPainter(),
      ),
    );
  }

  Widget _buildDot(double opacity) {
    return ListenableBuilder(
      listenable: _pulseController,
      builder: (context, child) {
        // Create pulsing effect
        double animValue = _pulseController.value;
        double dotOpacity = opacity + (0.3 * (0.5 + 0.5 * 
            (1 - (2 * animValue - 1).abs())));
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: dotOpacity.clamp(0.0, 1.0)),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}

// Custom painter to draw the LMS logo
class LmsLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;

    // Scale factor based on original viewBox (200x80)
    double scaleX = size.width / 200;
    double scaleY = size.height / 80;

    canvas.save();
    canvas.scale(scaleX, scaleY);

    // Top decorative ribbon/book pages
    Path ribbonPath = Path();
    ribbonPath.moveTo(100, 15);
    ribbonPath.cubicTo(115, 10, 130, 15, 145, 18);
    ribbonPath.lineTo(145, 20);
    ribbonPath.cubicTo(130, 17, 115, 12, 100, 17);
    ribbonPath.cubicTo(85, 12, 70, 17, 55, 20);
    ribbonPath.lineTo(55, 18);
    ribbonPath.cubicTo(70, 15, 85, 10, 100, 15);
    ribbonPath.close();
    canvas.drawPath(ribbonPath, fillPaint);

    // Letter "L" - arc shape
    Path lPath = Path();
    lPath.moveTo(40, 50);
    lPath.arcToPoint(
      const Offset(55, 35),
      radius: const Radius.circular(15),
      clockwise: true,
    );
    canvas.drawPath(lPath, strokePaint);

    // Letter "M" - stylized
    Path mPath = Path();
    mPath.moveTo(55, 45);
    mPath.cubicTo(65, 45, 70, 55, 80, 40);
    mPath.lineTo(80, 25);
    mPath.moveTo(80, 25);
    mPath.lineTo(80, 50);
    canvas.drawPath(mPath, strokePaint);

    // Letter "S" - infinity-like shape
    Path sPath1 = Path();
    sPath1.addOval(Rect.fromCircle(center: const Offset(107, 42), radius: 12));
    canvas.drawPath(sPath1, strokePaint);

    // Second part of S - stylized curve
    Path sPath2 = Path();
    sPath2.moveTo(130, 42);
    sPath2.cubicTo(125, 42, 125, 55, 135, 55);
    sPath2.cubicTo(150, 55, 155, 35, 135, 35);
    sPath2.cubicTo(125, 35, 130, 42, 145, 42);
    canvas.drawPath(sPath2, strokePaint);

    // Bottom underline decoration
    final underlinePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    Path underlinePath = Path();
    underlinePath.moveTo(55, 58);
    underlinePath.quadraticBezierTo(100, 65, 145, 58);
    canvas.drawPath(underlinePath, underlinePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
