import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class NutechBackground extends StatelessWidget {
  const NutechBackground({
    super.key,
    required this.child,
    this.showTopAccents = true,
    this.showBottomBackground = true,
    this.bottomAsset = 'assets/images/ui/bottombackground1.png',
  });

  final Widget child;
  final bool showTopAccents;
  final bool showBottomBackground;

  /// Default is bottombackground1 (auth illustration).
  /// Use bottombackground2 for dashboard/logs/profile/admin screens.
  final String bottomAsset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          if (showTopAccents)
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/ui/headerdesign.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

          if (showBottomBackground)
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                bottomAsset,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

          // Teal overlay (keeps the look consistent with your figma)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(color: AppTheme.teal.withOpacity(0.06)),
            ),
          ),

          child,
        ],
      ),
    );
  }
}
