import 'package:flutter/material.dart';
import 'package:game_dashboard/ui/home_page.dart';
import 'package:game_dashboard/ui/providers/theme_mode_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final baseDark = ThemeData.dark().textTheme;
    final base = ThemeData.light().textTheme;
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.indigo)
        .copyWith(surfaceVariant: Colors.deepPurple.shade50);
    final colorSchemeDark = ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.dark,
    ).copyWith(
      surface: const Color(0xFF161625),
      background: const Color(0xFF111111),
      surfaceVariant: const Color(0xFF2C3143),
    );
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        colorScheme: colorScheme,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        textTheme: base
            .copyWith(
              bodyLarge: base.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              titleLarge:
                  base.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              titleMedium:
                  base.titleMedium!.copyWith(fontWeight: FontWeight.w600),
            )
            .apply(
              displayColor: colorScheme.onSurface.withOpacity(0.75),
              bodyColor: colorScheme.onSurface,
            ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: colorSchemeDark.background,
        useMaterial3: true,
        colorScheme: colorSchemeDark,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        textTheme: baseDark
            .copyWith(
                bodyLarge:
                    baseDark.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                titleLarge:
                    baseDark.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                titleMedium:
                    baseDark.titleMedium!.copyWith(fontWeight: FontWeight.w600))
            .apply(
              displayColor: colorSchemeDark.onSurface.withOpacity(0.75),
              bodyColor: colorSchemeDark.onSurface,
            ),
      ),
      home:  HomePage(),
    );
  }
}
