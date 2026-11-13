import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/widgets/fullscreen_image_viewer.dart';

class GallerySection extends StatefulWidget {
  const GallerySection({super.key});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  final List<String> categories = ['Wedding', 'Portrait', 'Graduation', 'Events', 'Fashion'];
  String selectedCategory = 'Wedding';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Responsive.horizontalPadding(context).copyWith(top: 60, bottom: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Gallery',
            subtitle: 'Curated visuals across genres with rich tone and motion.',
          ),
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                return GestureDetector(
                  onTap: () => setState(() => selectedCategory = category),
                  child: AnimatedContainer(
                    duration: 240.ms,
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryGold : AppColors.surface,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      category,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: isSelected ? AppColors.background : AppColors.white,
                          ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),
          GridView.builder(
            itemCount: AppImages.galleryByCategory[selectedCategory]?.length ?? 0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.gridColumns(context, mobile: 1, tablet: 2, desktop: 4),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: Responsive.isMobile(context) ? 1.0 : 1.1,
            ),
            itemBuilder: (context, index) {
              final images = AppImages.galleryByCategory[selectedCategory] ?? [];
              final url = images[index];
              return _GalleryItem(imageUrl: url, images: images, index: index);
            },
          ),
        ],
      ),
    );
  }
}

class _GalleryItem extends StatelessWidget {
  const _GalleryItem({required this.imageUrl, required this.images, required this.index});

  final String imageUrl;
  final List<String> images;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showFullscreenImage(context, images, initialIndex: index);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            imageUrl.startsWith('assets/')
                ? Image.asset(imageUrl, fit: BoxFit.cover)
                : Image.network(imageUrl, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.transparent, AppColors.background.withValues(alpha: 0.7)],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fade(duration: const Duration(milliseconds: 600)).scaleXY(begin: 0.98, end: 1.0);
  }
}
