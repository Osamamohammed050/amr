import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  Future<void> _launchPhone() => launchUrl(Uri.parse('tel:+20 10 19690729'));
  Future<void> _launchWhatsApp() => launchUrl(Uri.parse('https://wa.me/201019690729'));

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final width = MediaQuery.of(context).size.width;
    final heroHeight = isMobile
        ? min(MediaQuery.of(context).size.height * 0.65, 520.0)
        : isTablet
            ? min(MediaQuery.of(context).size.height * 0.7, 640.0)
            : 760.0;
    final titleStyle = Theme.of(context).textTheme.displayLarge?.copyWith(
          fontSize: isMobile ? 34 : isTablet ? 50 : 64,
        );
    final subtitleStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontSize: isMobile ? 16 : isTablet ? 22 : 28,
        );
    final blockWidth = min(width * 0.94, 720.0);

    return Container(
      height: heroHeight,
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: AppImages.hero,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: AppColors.surface),
              errorWidget: (context, url, error) => const Icon(Icons.photo, color: AppColors.gray),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.background.withValues(alpha: 0.72), AppColors.background.withValues(alpha: 0.92)],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: Responsive.horizontalPadding(context).copyWith(top: 28, bottom: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: blockWidth),
                    child: Text(
                      AppStrings.heroTitle,
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                      style: titleStyle,
                    ).animate().fade(duration: const Duration(milliseconds: 900)).moveY(begin: 40, end: 0),
                  ),
                  const SizedBox(height: 18),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: blockWidth),
                    child: Text(
                      AppStrings.heroSubtitle,
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                      style: subtitleStyle,
                    ).animate().fade(duration: const Duration(milliseconds: 1100)).moveY(begin: 40, end: 0),
                  ),
                  const SizedBox(height: 28),
                  Wrap(
                    runSpacing: 12,
                    spacing: 12,
                    alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context).go('/portfolio');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        ),
                        child: const Text('View Portfolio'),
                      ),
                      ElevatedButton(
                        onPressed: _launchPhone,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 1, 250, 254),
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.call, size: 20),
                            SizedBox(width: 8),
                            Text('Call'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _launchWhatsApp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.whatsapp,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.message, size: 20),
                            SizedBox(width: 8),
                            Text('WhatsApp'),
                          ],
                        ),
                      ),
                    ],
                  ).animate().fade(duration: const Duration(milliseconds: 1300)).moveY(begin: 40, end: 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
