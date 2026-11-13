import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/widgets/fullscreen_image_viewer.dart';

class FeaturedPortfolioSection extends StatelessWidget {
  const FeaturedPortfolioSection({super.key});

  @override
  Widget build(BuildContext context) {
    final itemCount = AppImages.featured.length;
    return Padding(
      padding: Responsive.horizontalPadding(context).copyWith(top: 60, bottom: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Featured portfolio',
            subtitle: 'Selected visual stories with polished mood, careful lighting, and cinematic detail.',
          ),
          GridView.builder(
            itemCount: itemCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.gridColumns(context, mobile: 1, tablet: 2, desktop: 3),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: Responsive.isMobile(context) ? 1.0 : 1.2,
            ),
            itemBuilder: (context, index) {
              return _FeaturedPortfolioItem(imageUrl: AppImages.featured[index], index: index);
            },
          ),
        ],
      ),
    );
  }
}

class _FeaturedPortfolioItem extends StatelessWidget {
  const _FeaturedPortfolioItem({required this.imageUrl, required this.index});

  final String imageUrl;
  final int index;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => showFullscreenImage(context, AppImages.featured, initialIndex: index),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              imageUrl.startsWith('assets/')
                  ? Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                    ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.transparent, AppColors.background.withValues(alpha: 0.74)],
                  ),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Text(
                  'Featured ${index + 1}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white),
                ),
              )
            ],
          ),
        ),
      ),
    ).animate().scale(duration: 500.ms, curve: Curves.easeOut).fadeIn(duration: 500.ms);
  }
}
