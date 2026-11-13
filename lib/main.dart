import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/router/app_router.dart';
import 'core/services/app_state.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const LuminaApp());
}

class LuminaApp extends StatelessWidget {
  const LuminaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Amr Shahin Photography',
        theme: AppTheme.theme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
