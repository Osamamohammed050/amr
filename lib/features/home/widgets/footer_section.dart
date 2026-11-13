import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: AppColors.surface,
      padding: Responsive.horizontalPadding(context).copyWith(top: 28, bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text('Amr Shahin Photography', style: TextStyle(color: AppColors.primaryGold, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text('Premium photography. Editorial visuals. Timeless storytelling.', style: TextStyle(color: AppColors.gray), textAlign: TextAlign.center),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Amr Shahin Photography', style: TextStyle(color: AppColors.primaryGold, fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 12),
                      Text('Premium photography. Editorial visuals. Timeless storytelling.', style: TextStyle(color: AppColors.gray)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 400 ),
                        child: const Text('Follow Me :', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600 , fontSize: 16))),
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                         Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.facebook, color: AppColors.white),
                              onPressed: () => _launchUrl('https://www.facebook.com/share/1JFKcYXh4r/'),
                            ),
                            const Text('Facebook', style: TextStyle(color: AppColors.gray, fontSize: 12)),
                          ],
                         ),
                         const SizedBox(width: 16),
                         Column(
                          children: [
                            IconButton(
                              icon: const FaIcon(FontAwesomeIcons.instagram, color: AppColors.white),
                              onPressed: () => _launchUrl('https://www.instagram.com/amr_photography_456?igsh=MTk1b3IxcndvM293cQ=='),
                            ),
                            const Text('Instagram', style: TextStyle(color: AppColors.gray, fontSize: 12)),
                          ],
                         ),
                         const SizedBox(width: 16),
                         Column(
                          children: [
                            IconButton(
                              icon: const FaIcon(FontAwesomeIcons.tiktok, color: AppColors.white),
                              onPressed: () => _launchUrl('https://www.tiktok.com/@amr_photography_456?_r=1&_t=ZS-97onTybz7YL'),
                            ),
                            const Text('TikTok', style: TextStyle(color: AppColors.gray, fontSize: 12)),
                          ],
                         ),
                          const SizedBox(width: 16),
                          Column(
                          children: [
                            IconButton(
                              icon: const FaIcon(FontAwesomeIcons.telegram, color: AppColors.white),
                              onPressed: () => _launchUrl('https://t.me/+20 10 1969 0729'),
                            ),
                            const Text('Telegram', style: TextStyle(color: AppColors.gray, fontSize: 12)),
                          ],
                         )


                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          const SizedBox(height: 24),
          Text(
            '© 2026 Osama Mohammed. All rights reserved.',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
