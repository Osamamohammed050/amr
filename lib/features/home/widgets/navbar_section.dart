import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/services/app_state.dart';
import '../../../core/utils/responsive.dart';

class NavbarSection extends StatelessWidget {
  const NavbarSection({super.key});

  void _openMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Menu', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 20),
                ...[
                  {'Home': '/'},
                  {'Portfolio': '/portfolio'},
                  {'About': '/about'},
                  {'Services': '/services'},
                  {'Contact': '/contact'},
                  {'Book Session': '/book-session'},
                ].map((item) {
                  final label = item.keys.first;
                  final target = item.values.first;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        GoRouter.of(context).go(target);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.surface,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(label, style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isScrolled = context.select<AppState, bool>((state) => state.isScrolled);
    final background = isScrolled ? AppColors.surface.withValues(alpha: 0.92) : AppColors.transparent;
    final padding = Responsive.horizontalPadding(context).copyWith(top: 16, bottom: 16);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        border: Border(bottom: BorderSide(color: AppColors.gray.withValues(alpha: isScrolled ? 0.08 : 0))),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Amr Shahin', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primaryGold)),
            if (!Responsive.isMobile(context))
              Row(
                children: [
                  _NavItem(label: 'Home', target: '/'),
                  _NavItem(label: 'Portfolio', target: '/portfolio'),
                  _NavItem(label: 'About', target: '/about'),
                  _NavItem(label: 'Services', target: '/services'),
                  _NavItem(label: 'Contact', target: '/contact'),
                ],
              )
            else
              // IconButton(
              //   onPressed: () => _openMobileMenu(context),
              //   icon: const Icon(Icons.menu, color: AppColors.white),
              //   tooltip: 'Open menu',
              // ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/book-session');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGold,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              child: const Text('Book Session'),
            )
          ],
        ),
      ),
    ).animate().fade(duration: const Duration(milliseconds: 600)).moveY(begin: -10, end: 0);
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.label, required this.target});

  final String label;
  final String target;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => GoRouter.of(context).go(target),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
