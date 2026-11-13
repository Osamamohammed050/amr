import 'dart:ui';

import 'package:flutter/material.dart';

class FullscreenImageViewer extends StatefulWidget {
  const FullscreenImageViewer({super.key, required this.imageUrls, this.initialIndex = 0});

  final List<String> imageUrls;
  final int initialIndex;

  @override
  State<FullscreenImageViewer> createState() => _FullscreenImageViewerState();
}

class _FullscreenImageViewerState extends State<FullscreenImageViewer> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.imageUrls.length - 1);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.92,
              maxHeight: MediaQuery.of(context).size.height * 0.88,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.white12, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 24,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: widget.imageUrls.length,
                        onPageChanged: (index) => setState(() => _currentIndex = index),
                        itemBuilder: (context, index) {
                          final imageUrl = widget.imageUrls[index];
                          final Widget imageWidget =
                              imageUrl.startsWith('assets/')
                                  ? Image.asset(imageUrl, fit: BoxFit.contain)
                                  : Image.network(imageUrl, fit: BoxFit.contain);

                          return InteractiveViewer(
                            panEnabled: false,
                            scaleEnabled: true,
                            minScale: 0.7,
                            maxScale: 4.0,
                            child: Hero(
                              tag: imageUrl,
                              child: imageWidget,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                if (widget.imageUrls.length > 1) ...[
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        iconSize: 32,
                        color: Colors.white70,
                        icon: const Icon(Icons.chevron_left),
                        onPressed: _currentIndex > 0
                            ? () => _pageController.previousPage(duration: const Duration(milliseconds: 280), curve: Curves.easeOut)
                            : null,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        iconSize: 32,
                        color: Colors.white70,
                        icon: const Icon(Icons.chevron_right),
                        onPressed: _currentIndex < widget.imageUrls.length - 1
                            ? () => _pageController.nextPage(duration: const Duration(milliseconds: 280), curve: Curves.easeOut)
                            : null,
                      ),
                    ),
                  ),
                ],
                Positioned(
                  top: 16,
                  right: 16,
                  child: Material(
                    color: Colors.white12,
                    shape: const CircleBorder(),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Helper to show the full-screen viewer.
Future<void> showFullscreenImage(BuildContext context, List<String> imageUrls, {int initialIndex = 0}) {
  return showDialog(
    context: context,
    barrierColor: Colors.black54,
    barrierDismissible: true,
    builder: (ctx) => FullscreenImageViewer(imageUrls: imageUrls, initialIndex: initialIndex),
  );
}
