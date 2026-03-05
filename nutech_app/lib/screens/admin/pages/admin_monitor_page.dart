import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class AdminMonitorPage extends StatefulWidget {
  const AdminMonitorPage({super.key});

  @override
  State<AdminMonitorPage> createState() => _AdminMonitorPageState();
}

class _AdminMonitorPageState extends State<AdminMonitorPage> {
  int _tab = 0; // 0 = Today, 1 = This Week

  @override
  Widget build(BuildContext context) {
    final items = <_MonitorItem>[
      const _MonitorItem(
        name: 'Juan Reynolds',
        site: 'Dahua',
        status: _MonitorStatus.clockedIn,
        timeText: '07:58 AM',
      ),
      const _MonitorItem(
        name: 'Miguel Santos',
        site: 'Dahua',
        status: _MonitorStatus.clockedOut,
        timeText: '05:12 PM',
      ),
      const _MonitorItem(
        name: 'Angela Cruz',
        site: 'Dahua',
        status: _MonitorStatus.alert,
        timeText: 'Missing Time-out',
      ),
      const _MonitorItem(
        name: 'Carlos Ramos',
        site: 'Dahua',
        status: _MonitorStatus.clockedIn,
        timeText: '08:09 AM',
      ),
      const _MonitorItem(
        name: 'Sophia Reyes',
        site: 'Dahua',
        status: _MonitorStatus.clockedIn,
        timeText: '08:02 AM',
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Center(
            child: Image.asset(
              'assets/images/branding/nutechlogo1.png',
              width: 62,
              height: 62,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 14),
          const _SectionPill(title: 'Attendance Monitoring'),

          const SizedBox(height: 16),

          Row(
            children: const [
              Expanded(
                child: _StatCard(
                  title: 'Currently Clocked In',
                  value: '31',
                  background: AppTheme.teal,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _StatCard(
                  title: 'Not Yet Clocked In',
                  value: '11',
                  background: Color(0xFFFFA826),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: const [
              Expanded(
                child: _StatCard(
                  title: 'Missing Time-Out',
                  value: '2',
                  background: AppTheme.danger,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _StatCard(
                  title: 'Overtime Detected',
                  value: '4',
                  background: AppTheme.teal,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _Segmented(
            left: 'Today',
            right: 'This Week',
            index: _tab,
            onChanged: (i) => setState(() => _tab = i),
          ),

          const SizedBox(height: 16),

          ...items.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _EmployeeRow(item: e),
              )),
        ],
      ),
    );
  }
}

class _SectionPill extends StatelessWidget {
  const _SectionPill({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        border: Border.all(color: Colors.black.withOpacity(0.25)),
      ),
      child: const Center(
        child: Text(
          'Attendance Monitoring',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.background,
  });

  final String title;
  final String value;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.14),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
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
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Segmented extends StatelessWidget {
  const _Segmented({
    required this.left,
    required this.right,
    required this.index,
    required this.onChanged,
  });

  final String left;
  final String right;
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withOpacity(0.10)),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => onChanged(0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: index == 0 ? AppTheme.teal : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  left,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: index == 0 ? Colors.white : AppTheme.ink,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => onChanged(1),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: index == 1 ? AppTheme.teal : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  right,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: index == 1 ? Colors.white : AppTheme.ink,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _MonitorStatus { clockedIn, clockedOut, alert }

class _MonitorItem {
  const _MonitorItem({
    required this.name,
    required this.site,
    required this.status,
    required this.timeText,
  });

  final String name;
  final String site;
  final _MonitorStatus status;
  final String timeText;
}

class _EmployeeRow extends StatelessWidget {
  const _EmployeeRow({required this.item});

  final _MonitorItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.black.withOpacity(0.08),
            child: Icon(Icons.person, color: Colors.black.withOpacity(0.45)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 2),
                Text(
                  item.site,
                  style: const TextStyle(color: AppTheme.muted, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _StatusPill(status: item.status),
              const SizedBox(height: 6),
              Text(
                item.timeText,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final _MonitorStatus status;

  @override
  Widget build(BuildContext context) {
    late final Color bg;
    late final Color fg;
    late final String text;
    late final IconData? icon;

    switch (status) {
      case _MonitorStatus.clockedIn:
        bg = AppTheme.teal;
        fg = Colors.white;
        text = 'Clocked In';
        icon = null;
        break;
      case _MonitorStatus.clockedOut:
        bg = const Color(0xFFE9ECEF);
        fg = AppTheme.ink;
        text = 'Clocked Out';
        icon = null;
        break;
      case _MonitorStatus.alert:
        bg = AppTheme.danger;
        fg = Colors.white;
        text = 'ALERT';
        icon = Icons.warning_rounded;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: TextStyle(color: fg, fontWeight: FontWeight.w900, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
