import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../auth/login_screen.dart';

import '../reports/admin_daily_attendance_screen.dart';
import '../reports/admin_weekly_summary_screen.dart';
import '../reports/admin_late_absences_screen.dart';

class AdminReportsPage extends StatelessWidget {
  const AdminReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 18),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: c.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/branding/nutechlogo1.png',
                    width: 110,
                    height: 110,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 8),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.75),
                      border: Border.all(color: Colors.black.withOpacity(0.25)),
                    ),
                    child: const Center(
                      child: Text(
                        'Reports',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  _ReportButton(
                    label: 'Daily Attendance',
                    onTap: () => Navigator.pushNamed(
                      context,
                      AdminDailyAttendanceScreen.route,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ReportButton(
                    label: 'Weekly Summary',
                    onTap: () => Navigator.pushNamed(
                      context,
                      AdminWeeklySummaryScreen.route,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ReportButton(
                    label: 'Late & Absences',
                    onTap: () => Navigator.pushNamed(
                      context,
                      AdminLateAbsencesScreen.route,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ReportButton(
                    label: 'Export to CSV',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Frontend only: Export not connected yet.',
                          ),
                        ),
                      );
                    },
                  ),

                  const Spacer(),

                  // ✅ Logout button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE24B33),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginScreen.route,
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ReportButton extends StatelessWidget {
  const _ReportButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 10, 139, 144),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onTap,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
      ),
    );
  }
}
