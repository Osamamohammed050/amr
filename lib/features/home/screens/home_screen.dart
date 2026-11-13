import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/services/app_state.dart';
import '../widgets/about_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/featured_portfolio_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/gallery_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/navbar_section.dart';
import '../widgets/services_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.initialSection});

  final String? initialSection;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _galleryKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  Map<String, GlobalKey> get _sectionKeys => {
        'portfolio': _portfolioKey,
        'about': _aboutKey,
        'services': _servicesKey,
        'gallery': _galleryKey,
        'contact': _contactKey,
        'book-session': _contactKey,
      };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialSection != null) {
        _scrollToSection(widget.initialSection!);
      }
    });
  }

  void _onScroll() {
    final isScrolled = _scrollController.offset > 16;
    Provider.of<AppState>(context, listen: false).updateScroll(isScrolled);
  }

  Future<void> _scrollToSection(String section) async {
    final targetContext = _sectionKeys[section]?.currentContext;
    if (targetContext != null) {
      await Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.05,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double navbarHeight = 88.0;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: navbarHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(key: _heroKey, child: const HeroSection()),
                Container(key: _portfolioKey, child: const FeaturedPortfolioSection()),
                Container(key: _aboutKey, child: const AboutSection()),
                Container(key: _servicesKey, child: const ServicesSection()),
                Container(key: _galleryKey, child: const GallerySection()),
                Container(key: _contactKey, child: const ContactSection()),
                const FooterSection(), 
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              elevation: 2,
              color: Colors.transparent,
              child: const NavbarSection(),
            ),
          ),
        ],
      ),
    );
  }
}
