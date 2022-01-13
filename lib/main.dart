import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:movinfo/core/constants/theme_constant.dart';
import 'package:movinfo/core/extensions/context_entensions.dart';
import 'package:movinfo/view/Homepage/Homepage.dart';
import 'package:provider/provider.dart';

import 'core/init/cache/locale_manager.dart';
import 'core/init/navigation/navigate_service.dart';
import 'core/init/navigation/navigation_route.dart';
import 'core/state/theme_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleManager.init();
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(ThemeConstants.lightTheme),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movinfo',
      theme: themeNotifier.getTheme(),
      home: Homepage(),
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}
