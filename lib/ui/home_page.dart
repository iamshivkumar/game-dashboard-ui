import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:game_dashboard/ui/providers/background_music_player.dart';
import 'package:game_dashboard/ui/widgets/clip_polygon.dart';
import 'package:game_dashboard/ui/widgets/drawer.dart';
import 'package:game_dashboard/ui/widgets/my_card.dart';
import 'package:game_dashboard/ui/widgets/overview.dart';
import 'package:game_dashboard/ui/widgets/tile_card.dart';
import 'package:game_dashboard/utils/assets.dart';
import 'package:game_dashboard/utils/constants.dart';

import 'package:game_dashboard/utils/data.dart';
import 'package:game_dashboard/utils/image_icons.dart';
import 'package:game_dashboard/utils/pallate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'providers/theme_mode_provider.dart';
import 'widgets/last_maches_view.dart';
import 'widgets/my_tab_bar.dart';
import 'widgets/charecter_view.dart';

class HomePage extends HookConsumerWidget {
  HomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    print(width);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    final controller = useScrollController();
    final character = useState(Data.characters.first);
    final themeMode = ref.watch(themeModeProvider.state);

    final Widget row = Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              themeMode.state = themeMode.state == ThemeMode.dark
                  ? ThemeMode.light
                  : ThemeMode.dark;
            },
            icon: Icon(themeMode.state == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode),
          ),
          const SizedBox(width: 12),
          if (width > Constants.first) ...[
            ImageIcon(
              ImageIcons.logoUnColored,
              color: style.bodySmall!.color,
              size: 16,
            ),
            const SizedBox(width: 8),
            RichText(
              text: TextSpan(
                text: "shivkumarkonade",
                style: style.bodyMedium!.copyWith(fontSize: 12),
                children: [TextSpan(text: "#1822", style: style.bodySmall)],
              ),
            ),
          ],
          if (width < Constants.first)
            IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
              icon: Icon(Icons.history),
            ),
          SizedBox(width: width < Constants.first ? 16 : 8),
          Container(
            height: 36,
            width: 36,
            decoration: ShapeDecoration(
              color: scheme.onSurface,
              shape: const PolygonBorder(
                sides: 10,
              ),
            ),
            child: Center(
              child: Container(
                height: 32,
                width: 32,
                decoration: const ShapeDecoration(
                  shape: PolygonBorder(
                    sides: 10,
                  ),
                  image: DecorationImage(
                    image: AssetImage(Assets.profile),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: width < Constants.first
          ? Drawer(
              backgroundColor: Colors.transparent,
              child: LastMachesView(
                color: character.value.color,
              ),
            )
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutDrawer(
            color: character.value.color,
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 5,
                          child: MyTabBar(
                            color: character.value.color,
                            set: (v) => character.value = v,
                          ),
                        ),
                        width < Constants.first
                            ? row
                            : Expanded(flex: 2, child: row),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 5,
                          child: SingleChildScrollView(
                            controller: controller,
                            padding: const EdgeInsets.fromLTRB(8, 36, 8, 8),
                            child: Column(
                              children: [
                                CharactersView(
                                  character: character.value,
                                ),
                                OverView(
                                  character: character.value,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (width > Constants.first)
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 36, 8, 8),
                              child: LastMachesView(
                                color: character.value.color,
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
