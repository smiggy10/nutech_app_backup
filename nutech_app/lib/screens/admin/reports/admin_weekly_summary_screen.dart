import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/nutech_background.dart';

class AdminWeeklySummaryScreen extends StatelessWidget {
  const AdminWeeklySummaryScreen({super.key});

  static const route = '/admin/reports/weekly';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NutechBackground(
        bottomAsset: 'assets/images/ui/bottombackground2.png',
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
            child: Column(
              children: [
                const _TopBar(title: 'Weekly Summary'),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Expanded(child: _MiniCard(title: 'On Time', value: '168', color: AppTheme.teal)),
                    SizedBox(width: 12),
                    Expanded(child: _MiniCard(title: 'Late', value: '23', color: AppTheme.danger)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Expanded(child: _MiniCard(title: 'Absences', value: '11', color: AppTheme.danger)),
                    SizedBox(width: 12),
                    Expanded(child: _MiniCard(title: 'Overtime', value: '8', color: AppTheme.teal)),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView(
                    children: const [
                      _SummaryRow(name: 'Juan Reynolds', onTime: 5, late: 0, absent: 0),
                      _SummaryRow(name: 'Miguel Santos', onTime: 4, late: 1, absent: 0),
                      _SummaryRow(name: 'Angela Cruz', onTime: 4, late: 0, absent: 1),
                      _SummaryRow(name: 'Carlos Ramos', onTime: 3, late: 2, absent: 0),
                    ],
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

class _MiniCard extends StatelessWidget {
  const _MiniCard({required this.title, required this.value, required this.color});

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20)),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.name, required this.onTime, required this.late, required this.absent});

  final String name;
  final int onTime;
  final int late;
  final int absent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w900))),
          _Chip(label: 'On', value: onTime.toString(), color: AppTheme.teal),
          const SizedBox(width: 8),
          _Chip(label: 'Late', value: late.toString(), color: AppTheme.danger),
          const SizedBox(width: 8),
          _Chip(label: 'Abs', value: absent.toString(), color: AppTheme.danger),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.value, required this.color});

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text('$label $value', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12)),
    );
  }
}
