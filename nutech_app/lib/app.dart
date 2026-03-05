import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/register_password_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/verify_email_screen.dart';

import 'screens/home/home_shell.dart';

// ✅ Admin
import 'screens/admin/admin_shell.dart';
import 'screens/admin/reports/admin_daily_attendance_screen.dart';
import 'screens/admin/reports/admin_weekly_summary_screen.dart';
import 'screens/admin/reports/admin_late_absences_screen.dart';

import 'theme/app_theme.dart';

class NutechApp extends StatelessWidget {
  const NutechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicePreview.appBuilder(
      context,
      MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        debugShowCheckedModeBanner: false,
        title: 'Nutech',
        theme: AppTheme.light,
        initialRoute: LoginScreen.route,
        routes: {
          // Auth
          LoginScreen.route: (_) => const LoginScreen(),
          SignupScreen.route: (_) => const SignupScreen(),
          RegisterPasswordScreen.route: (_) => const RegisterPasswordScreen(),
          ForgotPasswordScreen.route: (_) => const ForgotPasswordScreen(),
          VerifyEmailScreen.route: (_) => const VerifyEmailScreen(),

          // User
          HomeShell.route: (_) => const HomeShell(),

          // Admin
          AdminShell.route: (_) => const AdminShell(),
          AdminDailyAttendanceScreen.route: (_) => const AdminDailyAttendanceScreen(),
          AdminWeeklySummaryScreen.route: (_) => const AdminWeeklySummaryScreen(),
          AdminLateAbsencesScreen.route: (_) => const AdminLateAbsencesScreen(),
        },
      ),
    );
  }
}
