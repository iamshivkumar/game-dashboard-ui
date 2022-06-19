import 'package:flutter/material.dart';
import 'package:game_dashboard/ui/models/character.dart';
import 'package:game_dashboard/utils/constants.dart';
import 'package:game_dashboard/utils/data.dart';
import 'package:game_dashboard/utils/image_icons.dart';

import '../../utils/pallate.dart';
import 'my_card.dart';

class CharactersView extends StatelessWidget {
  const CharactersView({Key? key, required this.character}) : super(key: key);
  final GameCharacter character;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;

    final width = MediaQuery.of(context).size.width;


    final List<Widget> widgets = Data.characters
        .where((element) => element.name != character.name)
        .map(
          (e) => Expanded(
            child: MyCard(
              color: e.color,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(),
                          Text(
                            e.name,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Win Ratio",
                                style: style.labelSmall!.copyWith(fontSize: 8),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "${e.winRate}%",
                                style: style.bodyLarge!.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Transform.translate(
                      offset: const Offset(0, -20),
                      child: Image.asset(
                        e.image,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
        .toList();

    final List<Widget> mainWidgets = [
      Expanded(
        child: MyCard(
          color: character.color,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "TOP AGENT",
                          style: style.titleMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              character.name,
                              style: style.displayMedium!.copyWith(
                                  // fontWeight: FontWeight.w800,
                                  color: Pallate.red,
                                  fontFamily: "Anton"),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'PLAYED ${character.hours}',
                                  style: style.bodySmall!.copyWith(
                                    color: scheme.onSurface.withOpacity(0.75),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: {
                            "Win Ratio": "${character.winRate}%",
                            "K/D Ratio": character.kdRatio,
                            "Dmg/Round": character.dmgRound,
                          }
                              .entries
                              .map(
                                (e) => Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.key,
                                        style: style.bodySmall!.copyWith(
                                          color: scheme.onSurface
                                              .withOpacity(0.75),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        e.value,
                                        style: style.bodyLarge,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ability Kills/Match',
                              style: style.bodySmall!.copyWith(
                                color: scheme.onSurface.withOpacity(0.75),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: {
                                ImageIcons.paranoia: character.ability[0],
                                ImageIcons.shadow: character.ability[1],
                                ImageIcons.darkCover: character.ability[2],
                              }
                                  .entries
                                  .map(
                                    (e) => Expanded(
                                      child: Row(
                                        children: [
                                          e.key,
                                          const SizedBox(width: 8),
                                          Text(
                                            e.value,
                                            style: style.bodyLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Transform.translate(
                  offset: const Offset(0, -32),
                  child: Image.asset(character.image),
                ),
              ),
            ],
          ),
        ),
      ),
      AspectRatio(
        aspectRatio: 1 / 2,
        child:Column(
                children: widgets,
              ),
      )
    ];
    return AspectRatio(
      aspectRatio:  2.125,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: mainWidgets,
      )
    );
  }
}
