import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/nutech_background.dart';

class AdminLateAbsencesScreen extends StatelessWidget {
  const AdminLateAbsencesScreen({super.key});

  static const route = '/admin/reports/late-absences';

  @override
  Widget build(BuildContext context) {
    final rows = const [
      _LA(name: 'Carlos Ramos', type: 'Late', detail: 'Arrived 09:10 AM'),
      _LA(name: 'Angela Cruz', type: 'Absent', detail: 'No attendance record'),
      _LA(name: 'Mark Dela Cruz', type: 'Late', detail: 'Arrived 09:03 AM'),
    ];

    return Scaffold(
      body: NutechBackground(
        bottomAsset: 'assets/images/ui/bottombackground2.png',
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
            child: Column(
              children: [
                const _TopBar(title: 'Late & Absences'),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.separated(
                    itemCount: rows.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) => _LACard(row: rows[i]),
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

class _LA {
  const _LA({required this.name, required this.type, required this.detail});
  final String name;
  final String type;
  final String detail;
}

class _LACard extends StatelessWidget {
  const _LACard({required this.row});
  final _LA row;

  @override
  Widget build(BuildContext context) {
    final isBad = row.type != 'Late' ? true : true; // both late/absent are warnings
    final color = isBad ? AppTheme.danger : AppTheme.teal;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(color: color.withOpacity(0.14), borderRadius: BorderRadius.circular(12)),
            child: Icon(row.type == 'Absent' ? Icons.person_off_rounded : Icons.access_time_rounded, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(row.name, style: const TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 2),
                Text(row.detail, style: const TextStyle(color: AppTheme.muted, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(999)),
            child: Text(row.type, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
