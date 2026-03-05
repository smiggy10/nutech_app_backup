import 'package:flutter/material.dart';
import 'package:nutech_app/theme/app_theme.dart';
import 'package:nutech_app/widgets/nutech_background.dart';

class AdminPendingApprovalsScreen extends StatefulWidget {
  const AdminPendingApprovalsScreen({super.key});

  static const route = '/admin/pending-approvals';

  @override
  State<AdminPendingApprovalsScreen> createState() => _AdminPendingApprovalsScreenState();
}

class _AdminPendingApprovalsScreenState extends State<AdminPendingApprovalsScreen> {
  // This list remains empty. No hardcoded "Maria Santos" or placeholders.
  List<Map<String, dynamic>> _pendingEmployees = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Your fetch logic will go here. 
    // Until it's called, _pendingEmployees remains [], and the UI shows nothing.
  }

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

                      // Title Bar
                      Container(
                        height: 52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.72),
                          border: Border.all(color: Colors.black.withOpacity(0.20)),
                        ),
                        child: const Text(
                          'Pending Approvals',
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // DATA CONTAINER
                      // If there is no data, this renders as an empty space (nothing).
                      _buildDataTable(), 
                    ],
                  ),
                ),
              ),

              // Bottom Action Buttons
              _buildBottomButtons(),
            ],
          ),
        ),
      ),
    );
  }

  // This function now returns NOTHING if there is no data.
  Widget _buildDataTable() {
    if (_pendingEmployees.isEmpty) {
      return const SizedBox.shrink(); // This ensures the container and names don't show at all.
    }

    return _TableCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Employees',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _pendingEmployees.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.black.withOpacity(0.05),
              indent: 16,
              endIndent: 16,
            ),
            itemBuilder: (context, index) {
              final employee = _pendingEmployees[index];
              return _employeeRow(
                employee['name'] ?? '',
                employee['photoUrl'], 
                () => _handleApprove(employee['id']),
              );
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _employeeRow(String name, String? photoUrl, VoidCallback onApprove) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFFE0E0E0),
            backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
            child: photoUrl == null 
              ? Icon(Icons.person, color: Colors.black.withOpacity(0.3)) 
              : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
          SizedBox(
            height: 34,
            width: 90,
            child: ElevatedButton(
              onPressed: onApprove,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.teal,
                padding: EdgeInsets.zero,
                shape: const StadiumBorder(),
              ),
              child: const Text(
                'Approve',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: _pendingEmployees.isEmpty ? null : () {
                  // Approve All logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.teal,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'Approve All',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(color: Color(0xFF5B5F66), fontWeight: FontWeight.w900, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleApprove(String id) {
    // Logic for Airtable
  }
}

class _TableCard extends StatelessWidget {
  const _TableCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: child,
      ),
    );
  }
}