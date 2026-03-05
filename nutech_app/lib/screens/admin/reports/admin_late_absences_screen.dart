import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:nutech_app/theme/app_theme.dart';
import 'package:nutech_app/widgets/nutech_background.dart';

class AdminLateAbsencesScreen extends StatefulWidget {
  const AdminLateAbsencesScreen({super.key});

  static const route = '/admin/late-absences';

  @override
  State<AdminLateAbsencesScreen> createState() => _AdminLateAbsencesScreenState();
}

class _AdminLateAbsencesScreenState extends State<AdminLateAbsencesScreen> {
  late Future<_LAReportPackage?> _reportData;
  late DateTimeRange _selectedRange;

  @override
  void initState() {
    super.initState();
    // Initialize with the current week of 2026 starting on Sunday
    _selectedRange = _getWeekRange(DateTime.now());
    _reportData = _fetchLateAbsences();
  }

  /// Snaps any date to a Sunday-to-Saturday range
  DateTimeRange _getWeekRange(DateTime date) {
    // weekday: Mon=1, Tue=2, Wed=3, Thu=4, Fri=5, Sat=6, Sun=7
    // If it's Sunday (7), we want to subtract 0. 
    // Otherwise, we subtract the current weekday value.
    int daysToSubtract = date.weekday % 7; 
    DateTime start = DateTime(date.year, date.month, date.day).subtract(Duration(days: daysToSubtract));
    DateTime end = start.add(const Duration(days: 6));
    return DateTimeRange(start: start, end: end);
  }

  Future<void> _changeWeek() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: _selectedRange,
      firstDate: DateTime(2025),
      lastDate: DateTime(2027),
      helpText: 'Select a date to pick that week (Sun-Sat)',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppTheme.teal),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        // Snap the selection to Sunday-Saturday
        _selectedRange = _getWeekRange(picked.start);
        _reportData = _fetchLateAbsences();
      });
    }
  }

  Future<_LAReportPackage?> _fetchLateAbsences() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    // Data fetching logic would go here
    return null; 
  }

  @override
  Widget build(BuildContext context) {
    final String dateString = 
        "${DateFormat('MMMM d').format(_selectedRange.start)} - ${DateFormat('MMMM d, yyyy').format(_selectedRange.end)}";

    return Scaffold(
      body: NutechBackground(
        bottomAsset: 'assets/images/ui/bottombackground2.png',
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: Image.asset(
                            'assets/images/branding/nutechlogo1.png',
                            height: 64,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildTitleBar(),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            _FilterCard(
                              text: 'Date Range: $dateString',
                              actionText: 'Change',
                              onTap: _changeWeek,
                            ),
                            const SizedBox(height: 20),
                            FutureBuilder<_LAReportPackage?>(
                              future: _reportData,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Padding(
                                    padding: EdgeInsets.only(top: 100),
                                    child: CircularProgressIndicator(color: AppTheme.teal),
                                  );
                                }

                                final data = snapshot.data;

                                if (data == null || data.rows.isEmpty) {
                                  return Column(
                                    children: [
                                      _buildStatsRow(late: '0', absent: '0'),
                                      const SizedBox(height: 20),
                                      _buildEmptyStateCard("No records found for this period"),
                                    ],
                                  );
                                }

                                return Column(
                                  children: [
                                    _buildStatsRow(late: data.totalLate, absent: data.totalAbsent),
                                    const SizedBox(height: 20),
                                    _TableCard(
                                      child: Table(
                                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
                                          for (final r in data.rows) _dataRow(r),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildBottomActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleBar() {
    return Column(
      children: [
        Divider(color: Colors.black.withOpacity(0.15), thickness: 1, height: 1),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: const Center(
            child: Text(
              'Late & Absences',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Colors.black),
            ),
          ),
        ),
        Divider(color: Colors.black.withOpacity(0.15), thickness: 1, height: 1),
      ],
    );
  }

  Widget _buildStatsRow({required String late, required String absent}) {
    return Row(
      children: [
        Expanded(
          child: _MiniStatCard(
            label: 'Total Late',
            value: late,
            color: const Color(0xFFE74C3C),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _MiniStatCard(
            label: 'Total Absent',
            value: absent,
            color: const Color(0xFFF39C12),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyStateCard(String message) {
    return _TableCard(
      child: Container(
        height: 240,
        alignment: Alignment.center,
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black.withOpacity(0.4),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Export Report', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Back', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow _headerRow() {
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

class _LAReportPackage {
  final String totalLate;
  final String totalAbsent;
  final List<_LArow> rows;
  const _LAReportPackage({required this.totalLate, required this.totalAbsent, required this.rows});
}

class _LArow {
  final String name;
  final int late;
  final int absent;
  const _LArow(this.name, this.late, this.absent);
}

class _FilterCard extends StatelessWidget {
  const _FilterCard({required this.text, required this.actionText, required this.onTap});
  final String text, actionText;
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
          BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 10, offset: const Offset(0, 6)),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500))),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: AppTheme.tealSoft, borderRadius: BorderRadius.circular(8)),
              child: Text(actionText, style: const TextStyle(fontWeight: FontWeight.w800, color: AppTheme.teal)),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  const _MiniStatCard({required this.label, required this.value, required this.color});
  final String label, value;
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
          BoxShadow(color: Colors.black.withOpacity(0.16), blurRadius: 10, offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14)),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22)),
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
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.10)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 10, offset: const Offset(0, 6)),
        ],
      ),
      child: child,
    );
  }
}