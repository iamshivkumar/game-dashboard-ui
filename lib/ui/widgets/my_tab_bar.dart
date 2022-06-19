import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_dashboard/ui/models/character.dart';
import 'package:game_dashboard/utils/data.dart';
import 'package:game_dashboard/utils/pallate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../enums/tabs.dart';
import '../providers/tab_provider.dart';

class MyTabBar extends ConsumerWidget {
  const MyTabBar({
    Key? key,
    required this.color,
    required this.set
  }) : super(key: key);
  final Color color;
  final Function(GameCharacter) set;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final tab = ref.watch(tabProvider.state);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: scheme.surfaceVariant,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: CupertinoSlidingSegmentedControl<String>(
          backgroundColor: scheme.surface,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          thumbColor: scheme.surfaceVariant,
          groupValue: tab.state,
          onValueChanged: (String? value) {
            if (value != null) {
              tab.state = value;
              final index = Tabs.values.indexOf(value);
              set(Data.characters[((index)%3)]);
            }
          },
          children: Map<String, Widget>.from(
            Tabs.values.asMap().map(
                  (key, value) => MapEntry(
                    value,
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        value,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: value != tab.state
                                ? scheme.onSurface.withOpacity(0.6)
                                : null),
                      ),
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
