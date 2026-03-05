How to apply this patch to your Flutter project

1) Copy the folders into your project root:
   - assets/icons/admin/
   - lib/screens/admin/

2) Replace these files in your project (ONLY if you want the background fix too):
   - lib/widgets/nutech_background.dart
   - lib/screens/home/home_shell.dart

3) Update lib/app.dart routes:
   - Add: import 'screens/admin/admin_shell.dart';
   - Add routes for AdminShell + report screens.

4) Run:
   flutter pub get
   flutter run
