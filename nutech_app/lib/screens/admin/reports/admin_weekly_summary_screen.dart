import 'package:flutter/material.dart';
import 'package:nutech_app/theme/app_theme.dart';
import 'package:nutech_app/widgets/nutech_background.dart';

class AdminWeeklySummaryScreen extends StatelessWidget {
  const AdminWeeklySummaryScreen({super.key});

  static const route = '/admin/weekly-summary';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NutechBackground(
        bottomAsset: 'assets/images/ui/bottombackground2.png',
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/branding/nutechlogo1.png',
                          height: 64,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const _TitleBar(title: 'Weekly Summary Report'),
                      const SizedBox(height: 12),

                      _FilterCard(
                        text: 'Date: March 14, 2026',
                        actionText: 'Change',
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      _FilterCard(
                        text: 'Department: Sales Team',
                        actionText: 'Change',
                        onTap: () {},
                      ),
                      const SizedBox(height: 14),

                      Row(
                        children: const [
                          Expanded(
                            child: _MiniStatCard(
                              label: 'Total\nEmployees',
                              value: '28',
                              color: Color(0xFF1FA651),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _MiniStatCard(
                              label: 'Present',
                              value: '4',
                              color: Color(0xFF148A8F),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _MiniStatCard(
                              label: 'Late',
                              value: '2',
                              color: Color(0xFFE74C3C),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _MiniStatCard(
                              label: 'Absent',
                              value: '28',
                              color: Color(0xFFF39C12),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),
                      Divider(color: Colors.black.withOpacity(0.25), height: 24),

                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.black.withOpacity(0.25),
                              thickness: 1,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Weekly Totals',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.black.withOpacity(0.25),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      _TotalsCard(
                        rows: const [
                          _TotalsRow('Total Work Hours', '369.9 hrs'),
                          _TotalsRow('Late Arrivals', '9'),
                          _TotalsRow('Absence Cases', '5'),
                          _TotalsRow('Overtime Hours', '69.9 hrs'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.teal,
                            foregroundColor: Colors.white,
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Export  Report',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE6E7EA),
                            foregroundColor: const Color(0xFF5B5F66),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleBar extends StatelessWidget {
  const _TitleBar({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.72),
        border: Border.all(color: Colors.black.withOpacity(0.20)),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _FilterCard extends StatelessWidget {
  const _FilterCard({
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  final String text;
  final String actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: Text(text)),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.tealSoft,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                actionText,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppTheme.teal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  const _MiniStatCard({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 12,
              height: 1.05,
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalsRow {
  final String left;
  final String right;
  const _TotalsRow(this.left, this.right);
}

class _TotalsCard extends StatelessWidget {
  const _TotalsCard({required this.rows});
  final List<_TotalsRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < rows.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Expanded(child: Text(rows[i].left)),
                  Text(
                    rows[i].right,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            if (i != rows.length - 1)
              Divider(height: 1, color: Colors.black.withOpacity(0.12)),
          ],
        ],
      ),
    );
  }
}