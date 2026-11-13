import 'package:flutter/widgets.dart';

class Responsive {
  Responsive._();

  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;

  static bool isMobile(BuildContext context) => width(context) < 600 && width(context) < 1024;
  static bool isTablet(BuildContext context) => width(context) >= 600 && width(context) < 1024;
  static bool isDesktop(BuildContext context) => width(context) >= 1024;

  static int gridColumns(BuildContext context, {int mobile = 1, int tablet = 2, int desktop = 4}) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  static EdgeInsets horizontalPadding(BuildContext context) {
    if (isMobile(context)) return const EdgeInsets.symmetric(horizontal: 20);
    if (isTablet(context)) return const EdgeInsets.symmetric(horizontal: 28);
    return const EdgeInsets.symmetric(horizontal: 32);
  }
}
