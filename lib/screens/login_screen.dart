import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _emailFocused = false;
  bool _passwordFocused = false;

  // Colors from the HTML design
  static const Color primaryColor = Color(0xFFB93333);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF18181B) : Colors.white;
    final textColor = isDark ? const Color(0xFFF3F4F6) : const Color(0xFF1F2937);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with slanted image
            _buildHeader(context, isDark, backgroundColor),
            
            // Login form section
            _buildLoginForm(context, isDark, textColor),
            
            // Bottom wave
            _buildBottomWave(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark, Color backgroundColor) {
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = screenHeight * 0.35;

    return SizedBox(
      height: headerHeight + 48, // Extra space for the avatar overflow
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Slanted header with image
          ClipPath(
            clipper: HeaderClipper(),
            child: Container(
              height: headerHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey[200],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // University building image
                  Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuA2axmZVVirsftksTp0CU4GoLhHJUFL92BSEeQy2z-A4X2II38Wql_cEE9MvgmRcD4AERyUBTcIvVgXNsCNH14KGXQ3zY8nGFl2200lFEE-U_wN2dsMQv-LI4wy_8IKxfmkjj7dMKfaH8kqieElX5yaje58mgdr8rBbtA9JNPYxkcriaB60tVQpuxl5evTZ-ECbhZs0w_X3xt01i5zj7Mf5ldAdmvhgVAqqsTad0W8ZdbMJlw1rFodfO0nygFZdcCTYq6tx9wHxjao',
                    fit: BoxFit.cover,
                    opacity: AlwaysStoppedAnimation(isDark ? 0.7 : 0.9),
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: isDark ? Colors.grey[700] : Colors.grey[300],
                        child: const Icon(Icons.school, size: 64, color: Colors.white54),
                      );
                    },
                  ),
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
                ],
              ),
            ),
          ),
          // Circular avatar with icon
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: backgroundColor, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: CustomPaint(
                    size: const Size(48, 48),
                    painter: GraduationCapPainter(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, bool isDark, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          // Login title
          Text(
            'Login',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: textColor,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 40),
          // Email field
          _buildTextField(
            controller: _emailController,
            label: 'Email 365',
            isFocused: _emailFocused,
            onFocusChange: (focused) => setState(() => _emailFocused = focused),
            isDark: isDark,
          ),
          const SizedBox(height: 32),
          // Password field
          _buildPasswordField(isDark),
          const SizedBox(height: 48),
          // Login button
          _buildLoginButton(),
          const SizedBox(height: 24),
          // Help link
          Center(
            child: TextButton(
              onPressed: () {
                // Handle help
              },
              child: Text(
                'Bantuan ?',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? const Color(0xFFF87171) : primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool isFocused,
    required Function(bool) onFocusChange,
    required bool isDark,
  }) {
    final hasText = controller.text.isNotEmpty;
    final isFloating = isFocused || hasText;
    
    return Focus(
      onFocusChange: onFocusChange,
      child: TextField(
        controller: controller,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: isDark ? Colors.white : Colors.grey[900],
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(
            fontSize: isFloating ? 12 : 14,
            fontWeight: FontWeight.w700,
            color: isFocused 
                ? primaryColor 
                : (isDark ? Colors.grey[400] : Colors.grey[500]),
          ),
          floatingLabelStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: primaryColor,
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: isDark ? Colors.grey[600]! : Colors.grey[300]!,
              width: 2,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: isDark ? Colors.grey[600]! : Colors.grey[300]!,
              width: 2,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          contentPadding: const EdgeInsets.only(bottom: 8),
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildPasswordField(bool isDark) {
    final hasText = _passwordController.text.isNotEmpty;
    final isFloating = _passwordFocused || hasText;

    return Focus(
      onFocusChange: (focused) => setState(() => _passwordFocused = focused),
      child: TextField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: isDark ? Colors.white : Colors.grey[900],
        ),
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: GoogleFonts.poppins(
            fontSize: isFloating ? 12 : 14,
            fontWeight: FontWeight.w700,
            color: _passwordFocused 
                ? primaryColor 
                : (isDark ? Colors.grey[400] : Colors.grey[500]),
          ),
          floatingLabelStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: primaryColor,
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: isDark ? Colors.grey[600]! : Colors.grey[300]!,
              width: 2,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: isDark ? Colors.grey[600]! : Colors.grey[300]!,
              width: 2,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          contentPadding: const EdgeInsets.only(bottom: 8),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: isDark ? Colors.grey[400] : Colors.grey[500],
              size: 20,
            ),
            onPressed: () {
              setState(() => _obscurePassword = !_obscurePassword);
            },
          ),
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Handle login
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 4,
          shadowColor: primaryColor.withValues(alpha: 0.4),
        ),
        child: Text(
          'Log In',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomWave() {
    return SizedBox(
      height: 128,
      width: double.infinity,
      child: CustomPaint(
        painter: WavePainter(color: primaryColor.withValues(alpha: 0.9)),
      ),
    );
  }
}

// Custom clipper for the slanted header
class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.85);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// Custom painter for the bottom wave
class WavePainter extends CustomPainter {
  final Color color;

  WavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.33);
    path.quadraticBezierTo(
      size.width * 0.25, size.height,
      size.width * 0.5, size.height * 0.33,
    );
    path.quadraticBezierTo(
      size.width * 0.75, size.height * -0.33,
      size.width, size.height * 0.33,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for graduation cap icon
class GraduationCapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final scale = size.width / 24;
    canvas.scale(scale);

    // Cap top (diamond shape)
    final capPath = Path();
    capPath.moveTo(12, 3);
    capPath.lineTo(1, 9);
    capPath.lineTo(12, 15);
    capPath.lineTo(23, 9);
    capPath.close();
    canvas.drawPath(capPath, paint);

    // Left side tassle holder
    final tasslePath = Path();
    tasslePath.moveTo(5, 10);
    tasslePath.lineTo(5, 15);
    tasslePath.lineTo(12, 19);
    tasslePath.lineTo(19, 15);
    tasslePath.lineTo(19, 10);
    canvas.drawPath(tasslePath, paint..style = PaintingStyle.stroke..strokeWidth = 1.5);

    // Tassel
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(19, 10), 1, paint);
    canvas.drawLine(
      const Offset(19, 10),
      const Offset(21, 16),
      paint..style = PaintingStyle.stroke..strokeWidth = 1.2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
