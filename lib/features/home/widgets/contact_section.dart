import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/section_title.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent successfully.')),
      );
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  Future<void> _launchPhone() => launchUrl(Uri.parse('tel:+20 10 19690729'));
  Future<void> _launchWhatsApp() => launchUrl(Uri.parse('https://wa.me/201019690729'));

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Padding(
      padding: Responsive.horizontalPadding(context).copyWith(top: 60, bottom: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Contact', subtitle: AppStrings.contactTitle),
          isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _contactDetails(context)),
        const SizedBox(width: 28),
        Expanded(child: _contactForm(context)),
      ],
    ).animate().fadeIn(duration: 700.ms);
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _contactDetails(context),
        const SizedBox(height: 28),
        _contactForm(context),
      ],
    ).animate().fadeIn(duration: 700.ms);
  }

  Widget _contactDetails(BuildContext context) {
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
          Text('Get in touch', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Text('Phone', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8),
          Text('+20 10 19690729', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.primaryGold)),
          const SizedBox(height: 20),
          Text('Email', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8),
          Text('studio@amrshahin.com', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.primaryGold)),
          const SizedBox(height: 20),
          Wrap(
            runSpacing: 12,
            spacing: 16,
            children: [
              ElevatedButton(
                onPressed: _launchPhone,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 1, 250, 254),
                  foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
          ),
        ],
      ),
    );
  }

  Widget _contactForm(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 28),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Send a message', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              style: const TextStyle(color: AppColors.white),
              decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
              validator: (value) => value?.isEmpty == true ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              style: const TextStyle(color: AppColors.white),
              decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
              validator: (value) {
                if (value?.isEmpty == true) return 'Please enter your email';
                if (!value!.contains('@')) return 'Please enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _messageController,
              style: const TextStyle(color: AppColors.white),
              maxLines: 6,
              decoration: const InputDecoration(labelText: 'Message', border: OutlineInputBorder()),
              validator: (value) => value?.isEmpty == true ? 'Please write a message' : null,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGold),
                child: _isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: AppColors.white, strokeWidth: 2)) : const Text('Send Message'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
