import 'package:flutter/material.dart';
import 'package:nutech_app/theme/app_theme.dart';
import 'package:nutech_app/widgets/nutech_background.dart';

class AdminDailyAttendanceScreen extends StatelessWidget {
  const AdminDailyAttendanceScreen({super.key});

  static const route = '/admin/daily-attendance';

  @override
  Widget build(BuildContext context) {
    final rows = <_DailyRow>[
      _DailyRow('Juan Reynolds', '08:05 AM', '05:12 PM', '9.1', 'On Time'),
      _DailyRow('Maria Santos', '08:30 AM', '05:00 PM', '7.5', 'Late'),
      _DailyRow('David Lee', '--', '--', '--', 'Absent'),
      _DailyRow('Rachel Adams', '07:55 AM', '06:30 PM', '10.5', 'Overtime'),
      _DailyRow('Michael Torres', '09:00 AM', '--', '--', 'Missed Out'),
      _DailyRow('Emily Wong', '08:15 AM', '05:15 PM', '8.0', 'On Time'),
    ];

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
                      const SizedBox(height: 2),
                      Center(
                        child: Image.asset(
                          'assets/images/branding/nutechlogo1.png',
                          height: 64,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const _TitleBar(title: 'Daily Attendance Report'),
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
                              label: 'Present',
                              value: '28',
                              color: AppTheme.teal,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _MiniStatCard(
                              label: 'Late',
                              value: '4',
                              color: Color(0xFFE74C3C),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _MiniStatCard(
                              label: 'Absent',
                              value: '2',
                              color: Color(0xFFF39C12),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _MiniStatCard(
                              label: 'Overtime',
                              value: '28',
                              color: Color(0xFF5DADE2),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      Divider(color: Colors.black.withOpacity(0.25), height: 22),

                      _TableCard(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minWidth: 520),
                            child: Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              border: TableBorder.all(
                                color: Colors.black.withOpacity(0.18),
                                width: 1,
                              ),
                              columnWidths: const {
                                0: FlexColumnWidth(2.2),
                                1: FlexColumnWidth(1.2),
                                2: FlexColumnWidth(1.2),
                                3: FlexColumnWidth(0.9),
                                4: FlexColumnWidth(1.2),
                              },
                              children: [
                                _headerRow(),
                                for (final r in rows) _dataRow(r),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom buttons (fixed)
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        );

    return TableRow(
      decoration: const BoxDecoration(color: Color(0xFFE7E7E7)),
      children: [
        cell('Employee'),
        cell('Time In'),
        cell('Time Out'),
        cell('Hours'),
        cell('Status'),
      ],
    );
  }

  TableRow _dataRow(_DailyRow r) {
    Widget cell(Widget child) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: child,
        );

    return TableRow(
      children: [
        cell(Text(r.employee)),
        cell(Text(r.timeIn)),
        cell(Text(r.timeOut)),
        cell(Text(r.hours)),
        cell(Align(
          alignment: Alignment.centerLeft,
          child: _StatusChip(status: r.status),
        )),
      ],
    );
  }
}

class _DailyRow {
  final String employee;
  final String timeIn;
  final String timeOut;
  final String hours;
  final String status;

  _DailyRow(this.employee, this.timeIn, this.timeOut, this.hours, this.status);
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
      height: 62,
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
              fontWeight: FontWeight.w800,
              fontSize: 12,
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

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final s = status.toLowerCase().trim();

    Color bg;
    if (s == 'on time') {
      bg = const Color(0xFF17A673);
    } else if (s == 'late') {
      bg = const Color(0xFFE74C3C);
    } else if (s == 'absent') {
      bg = const Color(0xFFF39C12);
    } else if (s == 'overtime') {
      bg = const Color(0xFF5DADE2);
    } else {
      bg = const Color(0xFFE74C3C); // missed out / alert
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 12,
        ),
      ),
    );
  }
}