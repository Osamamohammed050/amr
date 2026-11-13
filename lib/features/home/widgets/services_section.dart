import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/section_title.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});
  

  @override
  Widget build(BuildContext context) {
    final cards = [
      _ServiceData(
        icon: FontAwesomeIcons.ring,
        title: 'Wedding',
        description: 'Capturing emotive ceremony and editorial portraits with cinematic polish.',
        price: '\$\$\$',
      ),
      _ServiceData(
        icon: FontAwesomeIcons.cameraRetro,
        title: 'Portrait',
        description: 'Personal branding and lifestyle portraits tailored for creative professionals.',
        price: '\$\$\$',
      ),
      _ServiceData(
        icon: FontAwesomeIcons.tshirt,
        title: 'Fashion',
        description: 'Editorial styling, mood-driven lighting, and modern visual storytelling.',
        price: '\$\$\$',
      ),
    ];

    final isMobile = Responsive.isMobile(context);
    return Padding(
      padding: Responsive.horizontalPadding(context).copyWith(top: 60, bottom: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Services',
            subtitle: 'Full-service photography packages for every visual story.',
          ),
          GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: cards.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.gridColumns(context, mobile: 1, tablet: 2, desktop: 3),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: isMobile ? 1.1 : 0.95,
            ),
            itemBuilder: (context, index) {
              return _ServiceCard(data: cards[index], delay: 160 * index);
            },
          )
        ],
      ),
    );
  }
}

class _ServiceData {
  const _ServiceData({required this.icon, required this.title, required this.description, required this.price});

  final FaIconData icon;
  final String title;
  final String description;
  final String price;
}

class _ServiceCard extends StatefulWidget {
  const _ServiceCard({required this.data, required this.delay});

  final _ServiceData data;
  final int delay;

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;
  Future<void> _launchWhatsApp() => launchUrl(Uri.parse('https://wa.me/201019690729'));

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: 240.ms,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: _hovered ? AppColors.primaryGold : AppColors.transparent, width: 1.6),
        ),
        padding: EdgeInsets.all(isMobile ? 20 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FaIcon(widget.data.icon, color: AppColors.primaryGold, size: 28),
            const SizedBox(height: 20),
            Text(widget.data.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(widget.data.description, style: Theme.of(context).textTheme.bodyLarge),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.data.price, style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.primaryGold)),
                ElevatedButton(
                onPressed: _launchWhatsApp, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD8B87E),
                  foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.message, size: 20),
                    SizedBox(width: 8),
                    Text('Book Now'),
                  ],
                ),
              ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fade(duration: 600.ms, delay: Duration(milliseconds: widget.delay));
  }
}
