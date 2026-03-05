import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/nutech_background.dart';
import '../../widgets/nutech_text_field.dart';
import '../../widgets/primary_button.dart';

import '../home/home_shell.dart';
import '../admin/admin_shell.dart'; // ✅ ADD THIS
import 'forgot_password_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const route = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true;

  final _userIdCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void dispose() {
    _userIdCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final user = _userIdCtrl.text.trim();
    final pass = _passCtrl.text.trim();

    // ✅ Frontend-only rule:
    if (user == 'admin' && pass == 'admin') {
      Navigator.pushReplacementNamed(context, AdminShell.route);
      return;
    }

    // otherwise go to normal user dashboard
    Navigator.pushReplacementNamed(context, HomeShell.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NutechBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 52, 24, 24),
            child: Column(
              children: [
                const SizedBox(height: 10),

                // Logo (no container behind)
                Image.asset(
                  'assets/images/branding/nutechlogo1.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 28),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('User ID', style: Theme.of(context).textTheme.titleMedium),
                ),
                const SizedBox(height: 10),
                NutechTextField(
                  controller: _userIdCtrl,
                  hint: 'Enter user id',
                ),
                const SizedBox(height: 18),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Password', style: Theme.of(context).textTheme.titleMedium),
                ),
                const SizedBox(height: 10),
                NutechTextField(
                  controller: _passCtrl,
                  hint: 'Enter password',
                  obscureText: _obscure,
                  suffix: IconButton(
                    icon: Image.asset('assets/icons/visibility.png', width: 22, height: 22),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),

                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(context, ForgotPasswordScreen.route),
                    child: const Text('Forgot password?'),
                  ),
                ),

                const SizedBox(height: 14),
                PrimaryButton(
                  label: 'Login',
                  onPressed: _handleLogin, // ✅ HERE
                ),

                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, SignupScreen.route),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(color: AppTheme.ink, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.black.withOpacity(0.25))),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Or Sign in with', style: TextStyle(color: AppTheme.muted)),
                    ),
                    Expanded(child: Divider(color: Colors.black.withOpacity(0.25))),
                  ],
                ),

                const SizedBox(height: 14),
                SizedBox(
                  width: 240,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.g_mobiledata, size: 28),
                    label: const Text('Google', style: TextStyle(fontWeight: FontWeight.w700)),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      side: BorderSide(color: Colors.black.withOpacity(0.10)),
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
}