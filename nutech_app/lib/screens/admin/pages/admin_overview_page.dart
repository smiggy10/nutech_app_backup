import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class AdminOverviewPage extends StatelessWidget {
  const AdminOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Column(
        children: [
          // Logo
          Image.asset(
            'assets/images/branding/nutechlogo1.png',
            width: 110,
            height: 110,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 8),

          // Title pill
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.75),
              border: Border.all(color: Colors.black.withOpacity(0.25)),
            ),
            child: const Center(
              child: Text('Overview', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            ),
          ),

          const SizedBox(height: 18),

          // Top stats
          const Row(
            children: [
              Expanded(child: _MiniStat(title: 'On Time Today', value: '85', isDanger: false)),
              SizedBox(width: 12),
              Expanded(child: _MiniStat(title: 'Late Today', value: '11', isDanger: true)),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(child: _MiniStat(title: 'Absent Today', value: '2', isDanger: false)),
              SizedBox(width: 12),
              Expanded(child: _MiniStat(title: 'Clocked in Now', value: '29', isDanger: false)),
            ],
          ),

          const SizedBox(height: 14),

          // Pending / Missing
          const _AlertRow(
            iconAsset: 'assets/icons/admin/SandWatch.png',
            title: 'Pending Approval',
            value: '85',
            badgeColor: AppTheme.teal,
          ),
          const SizedBox(height: 10),
          const _AlertRow(
            iconAsset: 'assets/icons/admin/TimeLimit.png',
            title: 'Missing Time-Out',
            value: '85',
            badgeColor: Color(0xFFE24B33),
          ),

          const SizedBox(height: 22),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Data Status', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
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
            child: const Column(
              children: [
                _DataStatusRow(
                  iconAsset: 'assets/icons/admin/Person-A.png',
                  label: 'Total Employees',
                  value: '85',
                  valueColor: AppTheme.ink,
                ),
                _DividerLine(),
                _DataStatusRow(
                  iconAsset: 'assets/icons/admin/Attendance.png',
                  label: 'Absences This Week',
                  value: '10',
                  valueColor: Colors.red,
                ),
                _DividerLine(),
                _DataStatusRow(
                  iconAsset: 'assets/icons/admin/Overtime.png',
                  label: 'Overtime Hours',
                  value: '63',
                  valueColor: AppTheme.ink,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
          ),
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
  });

  final String iconAsset;
  final String title;
  final String value;
  final Color badgeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
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
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}

class _DataStatusRow extends StatelessWidget {
  const _DataStatusRow({
    required this.iconAsset,
    required this.label,
    required this.value,
    required this.valueColor,
  });

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