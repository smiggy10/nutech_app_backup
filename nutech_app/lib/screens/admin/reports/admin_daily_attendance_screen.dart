import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/nutech_background.dart';

class AdminDailyAttendanceScreen extends StatelessWidget {
  const AdminDailyAttendanceScreen({super.key});

  static const route = '/admin/reports/daily';

  @override
  Widget build(BuildContext context) {
    final rows = const [
      _DailyRow(name: 'Juan Reynolds', site: 'Dahua', inTime: '07:58 AM', outTime: '—', status: 'Clocked In'),
      _DailyRow(name: 'Miguel Santos', site: 'Dahua', inTime: '08:05 AM', outTime: '05:12 PM', status: 'Completed'),
      _DailyRow(name: 'Angela Cruz', site: 'Dahua', inTime: '08:01 AM', outTime: '—', status: 'Missing Out'),
      _DailyRow(name: 'Carlos Ramos', site: 'Dahua', inTime: '09:10 AM', outTime: '—', status: 'Late'),
    ];

    return Scaffold(
      body: NutechBackground(
        bottomAsset: 'assets/images/ui/bottombackground2.png',
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
            child: Column(
              children: [
                _TopBar(title: 'Daily Attendance'),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black.withOpacity(0.08)),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.calendar_month_rounded, color: AppTheme.teal),
                      SizedBox(width: 10),
                      Text('Today', style: TextStyle(fontWeight: FontWeight.w900)),
                      Spacer(),
                      Icon(Icons.expand_more_rounded),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.separated(
                    itemCount: rows.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) => _DailyRowCard(row: rows[i]),
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

class _TopBar extends StatelessWidget {
  const _TopBar({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }
}

class _DailyRow {
  const _DailyRow({
    required this.name,
    required this.site,
    required this.inTime,
    required this.outTime,
    required this.status,
  });

  final String name;
  final String site;
  final String inTime;
  final String outTime;
  final String status;
}

class _DailyRowCard extends StatelessWidget {
  const _DailyRowCard({required this.row});
  final _DailyRow row;

  @override
  Widget build(BuildContext context) {
    Color statusColor = AppTheme.teal;
    if (row.status == 'Late' || row.status == 'Missing Out') statusColor = AppTheme.danger;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(row.name, style: const TextStyle(fontWeight: FontWeight.w900)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(999)),
                child: Text(
                  row.status,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(row.site, style: const TextStyle(color: AppTheme.muted, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: Text('IN: ${row.inTime}', style: const TextStyle(fontWeight: FontWeight.w800))),
              Expanded(child: Text('OUT: ${row.outTime}', style: const TextStyle(fontWeight: FontWeight.w800))),
            ],
          ),
        ],
      ),
    );
  }
}
