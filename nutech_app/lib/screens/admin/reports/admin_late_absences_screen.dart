import 'package:flutter/material.dart';
import 'package:nutech_app/theme/app_theme.dart';
import 'package:nutech_app/widgets/nutech_background.dart';

class AdminLateAbsencesScreen extends StatefulWidget {
  const AdminLateAbsencesScreen({super.key});

  static const route = '/admin/late-absences';

  @override
  State<AdminLateAbsencesScreen> createState() => _AdminLateAbsencesScreenState();
}

class _AdminLateAbsencesScreenState extends State<AdminLateAbsencesScreen> {
  String _who = 'Employees';
  String _dept = 'All Departments';

  final _rows = const [
    _LArow('Maria Santos', 3, 1),
    _LArow('David Lee', 3, 1),
    _LArow('Rachel Adams', 1, 1),
    _LArow('Mak Setevens', 1, 1),
  ];

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
                      const _TitleBar(title: 'Late & Absences'),
                      const SizedBox(height: 12),

                      _FilterCard(
                        text: 'Date Range: April 8 - April 14, 2026',
                        actionText: 'Change',
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      _FilterCard(
                        text: 'Department: All Departments',
                        actionText: 'Change',
                        onTap: () {},
                      ),
                      const SizedBox(height: 14),

                      Row(
                        children: const [
                          Expanded(
                            child: _MiniStatCard(
                              label: 'Total Late',
                              value: '12',
                              color: Color(0xFFE74C3C),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _MiniStatCard(
                              label: 'Total Absent',
                              value: '5',
                              color: Color(0xFFF39C12),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: _DropdownBox<String>(
                              value: _who,
                              items: const ['Employees', 'Sites'],
                              onChanged: (v) =>
                                  setState(() => _who = v ?? _who),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _DropdownBox<String>(
                              value: _dept,
                              items: const [
                                'All Departments',
                                'Sales Team',
                                'HR',
                                'Operations',
                              ],
                              onChanged: (v) =>
                                  setState(() => _dept = v ?? _dept),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      _TableCard(
                        child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          border: TableBorder.all(
                            color: Colors.black.withOpacity(0.18),
                            width: 1,
                          ),
                          columnWidths: const {
                            0: FlexColumnWidth(2.6),
                            1: FlexColumnWidth(1.0),
                            2: FlexColumnWidth(1.0),
                          },
                          children: [
                            _headerRow(),
                            for (final r in _rows) _dataRow(r),
                          ],
                        ),
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

  TableRow _headerRow() {
    Widget cell(String text) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Text(text, style: const TextStyle(fontWeight: FontWeight.w800)),
        );

    return const TableRow(
      decoration: BoxDecoration(color: Color(0xFFE7E7E7)),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Text('Employees', style: TextStyle(fontWeight: FontWeight.w800)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Text('Late', style: TextStyle(fontWeight: FontWeight.w800)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Text('Absent', style: TextStyle(fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }

  TableRow _dataRow(_LArow r) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 17,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.black54),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(r.name)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Center(child: Text('${r.late}')),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Center(child: Text('${r.absent}')),
        ),
      ],
    );
  }
}

class _LArow {
  final String name;
  final int late;
  final int absent;
  const _LArow(this.name, this.late, this.absent);
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
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
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
      height: 76,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
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
              fontSize: 14,
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
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableCard extends StatelessWidget {
  const _TableCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
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
      child: child,
    );
  }
}

class _DropdownBox<T> extends StatelessWidget {
  const _DropdownBox({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: items
              .map(
                (e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text('$e'),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}