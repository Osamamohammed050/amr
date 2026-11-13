import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/widgets/fullscreen_image_viewer.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.horizontalPadding(context).copyWith(top: 60, bottom: 60);
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'About', subtitle: AppStrings.aboutDescription),
          const SizedBox(height: 24),
          if (Responsive.isDesktop(context))
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _profileCard(context)),
                const SizedBox(width: 40),
                Expanded(child: _bioCard(context)),
              ],
            )
          else
            Column(
              children: [
                _profileCard(context),
                const SizedBox(height: 24),
                _bioCard(context),
              ],
            ),
        ],
      ),
    );
  }

  Widget _profileCard(BuildContext context) {
    final imageHeight = Responsive.isDesktop(context) ? 520.0 : Responsive.isTablet(context) ? 420.0 : 280.0;
    return GestureDetector(
      onTap: () => showFullscreenImage(context, [AppImages.about]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: SizedBox(
          height: imageHeight,
          width: double.infinity,
          child: Image.asset(
            AppImages.about,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ).animate().fadeIn(duration: 700.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _bioCard(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 28),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Biography', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Text(AppStrings.aboutDescription, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 28),
          Wrap(
            runSpacing: 16,
            spacing: 12,
            alignment: WrapAlignment.spaceBetween,
            children: const [
              _StatisticItem(value: '4+', label: 'Years experience'),
              _StatisticItem(value: '50+', label: 'Projects completed'),
              _StatisticItem(value: '5+', label: 'Awards won'),
            ],
          )
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideX(begin: 0.1, end: 0);
  }
}

class _StatisticItem extends StatelessWidget {
  const _StatisticItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.primaryGold)),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
