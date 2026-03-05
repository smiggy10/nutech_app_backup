import 'package:flutter/material.dart';
import 'package:nutech_app/theme/app_theme.dart';
import 'package:nutech_app/widgets/nutech_background.dart';

class PendingApprovalsPage extends StatelessWidget {
  const PendingApprovalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final employees = <String>[
      'Maria Santos',
      'David Lee',
      'Rachel Adams',
      'Mak Stevvens',
    ];

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

                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _TableCard(
                          child: Column(
                            children: [
                              Row(
                                children: const [
                                  SizedBox(width: 40),
                                  Expanded(
                                    child: Text(
                                      'Employees',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 90),
                                ],
                              ),

                              const SizedBox(height: 10),

                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: employees.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 8),
                                itemBuilder: (context, index) {
                                  final name = employees[index];

                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color:
                                            Colors.black.withOpacity(0.08),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 16,
                                          backgroundColor: Colors.black54,
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),

                                        const SizedBox(width: 12),

                                        Expanded(
                                          child: Text(
                                            name,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width: 90,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppTheme.teal,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              shape:
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            onPressed: () {
                                              // Approve single employee
                                            },
                                            child: const Text(
                                              'Approve',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              _buildBottomActions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleBar() {
    return Column(
      children: [
        Divider(color: Colors.black.withOpacity(0.15), thickness: 1),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            'Pending Approvals',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Divider(color: Colors.black.withOpacity(0.15), thickness: 1),
      ],
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // Approve all employees
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.teal,
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Approve All',
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
        border: Border.all(color: Colors.black.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: child,
    );
  }
}