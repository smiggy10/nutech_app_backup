import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import 'pending_approvals_page.dart';

class AdminOverviewPage extends StatefulWidget {
  const AdminOverviewPage({super.key});

  @override
  State<AdminOverviewPage> createState() => _AdminOverviewPageState();
}

class _AdminOverviewPageState extends State<AdminOverviewPage> {
  final List<dynamic> _todayLogs = []; 
  final List<dynamic> _allEmployees = [];

  @override
  Widget build(BuildContext context) {
    final onTimeCount = _todayLogs.where((l) => l['status'] == 'on-time').length;
    final lateCount = _todayLogs.where((l) => l['status'] == 'late').length;
    final absentCount = _todayLogs.where((l) => l['status'] == 'absent').length;
    final clockedInCount = _todayLogs.where((l) => l['isClockedIn'] == true).length;
    final missingTimeoutCount = _todayLogs.where((l) => l['needsTimeout'] == true).length;
    final totalEmployees = _allEmployees.length;

    return SingleChildScrollView(
      // ✅ Removed horizontal padding to allow Dividers to hit the screen edges
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ✅ Logo - Re-applied 20px horizontal padding
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 100), 
                child: Image.asset(
                  'assets/images/branding/nutechlogo1.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ✅ FIXED: Edge-to-edge lines with transparent background
          Column(
            children: [
              Divider(
                color: Colors.black.withOpacity(0.15), 
                thickness: 1, 
                height: 1,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                // No decoration or color here = transparent (shows background)
                child: Center(
                  child: Text(
                    'Overview', 
                    style: TextStyle(
                      fontSize: 26, 
                      fontWeight: FontWeight.w800,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.black.withOpacity(0.15), 
                thickness: 1, 
                height: 1,
              ),
            ],
          ),

          const SizedBox(height: 18),

          // ✅ Main Content - Re-applied 20px horizontal padding
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _MiniStat(title: 'On Time Today', value: onTimeCount.toString(), isDanger: false)),
                    const SizedBox(width: 12),
                    Expanded(child: _MiniStat(title: 'Late Today', value: lateCount.toString(), isDanger: true)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _MiniStat(title: 'Absent Today', value: absentCount.toString(), isDanger: false)),
                    const SizedBox(width: 12),
                    Expanded(child: _MiniStat(title: 'Clocked in Now', value: clockedInCount.toString(), isDanger: false)),
                  ],
                ),

                const SizedBox(height: 14),

                _AlertRow(
                  iconAsset: 'assets/icons/admin/SandWatch.png',
                  title: 'Pending Approval',
                  value: '0', 
                  badgeColor: AppTheme.teal,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PendingApprovalsPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                _AlertRow(
                  iconAsset: 'assets/icons/admin/TimeLimit.png',
                  title: 'Missing Time-Out',
                  value: missingTimeoutCount.toString(),
                  badgeColor: const Color(0xFFE24B33),
                ),

                const SizedBox(height: 22),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Data Status', 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(height: 12),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black.withOpacity(0.12)),
                  ),
                  child: Column(
                    children: [
                      _DataStatusRow(
                        iconAsset: 'assets/icons/admin/Person-A.png',
                        label: 'Total Employees',
                        value: totalEmployees.toString(),
                        valueColor: AppTheme.ink,
                      ),
                      const _DividerLine(),
                      const _DataStatusRow(
                        iconAsset: 'assets/icons/admin/Attendance.png',
                        label: 'Absences This Week',
                        value: '0',
                        valueColor: Colors.red,
                      ),
                      const _DividerLine(),
                      const _DataStatusRow(
                        iconAsset: 'assets/icons/admin/Overtime.png',
                        label: 'Overtime Hours',
                        value: '0',
                        valueColor: AppTheme.ink,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Supporting Widgets (Remain the same but optimized for padding) ---

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.title, required this.value, required this.isDanger});
  final String title;
  final String value;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    final bg = isDanger ? const Color(0xFFE24B33) : AppTheme.teal;
    return Container(
      height: 72,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class _AlertRow extends StatelessWidget {
  const _AlertRow({
    required this.iconAsset,
    required this.title,
    required this.value,
    required this.badgeColor,
    this.onTap,
  });
  final String iconAsset;
  final String title;
  final String value;
  final Color badgeColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black.withOpacity(0.12)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            Image.asset(iconAsset, width: 28, height: 28),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
            Container(
              width: 64,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(8)),
              child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
            ),
          ],
        ),
      ),
    );
  }
}

class _DataStatusRow extends StatelessWidget {
  const _DataStatusRow({required this.iconAsset, required this.label, required this.value, required this.valueColor});
  final String iconAsset;
  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Image.asset(iconAsset, width: 26, height: 26),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: valueColor)),
        ],
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();
  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, thickness: 1, color: Colors.black.withOpacity(0.08));
  }
}