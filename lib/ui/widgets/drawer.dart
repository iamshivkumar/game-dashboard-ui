import 'package:flutter/material.dart';
import 'package:game_dashboard/utils/image_icons.dart';
import 'package:game_dashboard/utils/pallate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/index_provider.dart';

class LayoutDrawer extends ConsumerWidget {
  const LayoutDrawer({Key? key,required this.color}) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final index = ref.watch(indexProvider.state);
    return Theme(
      data: theme.copyWith(useMaterial3: false),
      child: Container(
        width: 84,
        decoration: BoxDecoration(
          color: scheme.surface,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 4,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Center(
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: ImageIcons.logo,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: IntrinsicHeight(
                  child: NavigationRail(
                    minWidth: 84,
                    
                    extended: false,
                    onDestinationSelected: (v) {
                      index.state = v;
                    },
                    useIndicator: true,
                    selectedIconTheme: IconThemeData(color: Pallate.red),
                    backgroundColor: scheme.surface,
                    indicatorColor: Pallate.red.withOpacity(0.2),
                    destinations: [
                      NavigationRailDestination(
                        icon: ImageIcons.dashboard,
                        label: Text("Dashbaord"),
                      ),
                      NavigationRailDestination(
                        icon: ImageIcons.battle,
                        label: Text("Battles"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.map),
                        label: Text("Map"),
                      ),
                      NavigationRailDestination(
                        icon: ImageIcons.gun,
                        label: Text("Weapons"),
                      ),
                      NavigationRailDestination(
                        icon: ImageIcons.troffy,
                        label: Text("Rewards"),
                      ),
                    ],
                    selectedIndex: index.state,
                  ),
                ),
              ),
            ),
            const Divider(height: 0.5),
            AspectRatio(
              aspectRatio: 1,
              child: Material(
                color: Colors.transparent,
                child: Center(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.logout),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
