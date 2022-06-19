
import 'package:flutter/material.dart';
import 'package:game_dashboard/ui/models/character.dart';
import 'package:game_dashboard/ui/widgets/my_card.dart';
import 'package:game_dashboard/utils/pallate.dart';

import 'progress_clipper.dart';
import 'tile_card.dart';

class OverView extends StatelessWidget {
  const OverView({Key? key, required this.character}) : super(key: key);
  final GameCharacter character;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    return AspectRatio(
      aspectRatio: 2.125,
      child: Row(
        children: [
          Expanded(
            child: MyCard(
              color: character.color,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "COMPETITIVE OVERVIEW",
                            style: style.titleMedium,
                          ),
                        ),
                        SizedBox(
                          width: 128,
                          height: 40,
                          child: Theme(
                            data:
                                theme.copyWith(canvasColor: scheme.background),
                            child: DropdownButtonFormField<String>(
                              isDense: true,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                              ),
                              items: ["ACT2:E3"]
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  RadialBar(value: character.winRatio),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(),
                                      const SizedBox(),
                                      Text(
                                        "Win Rate",
                                        style: style.bodySmall!
                                            .copyWith(fontSize: 10),
                                      ),
                                      Text(
                                        "${character.winRate}%",
                                        style: style.titleLarge,
                                      ),
                                      const SizedBox(),
                                      const SizedBox(),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          ...{
                            Pallate.teal: "${character.wins} WINS",
                            Pallate.red: "${character.lose} LOSE"
                          }
                              .entries
                              .map(
                                (e) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: TileCard(
                                      color: e.key,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          e.value,
                                          style: style.bodyLarge,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList()
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: {
                                  "Kills": character.kills,
                                  "Headshots": character.headshots,
                                  "Deaths": character.deaths,
                                }
                                    .entries
                                    .map((e) => ExpandedTile(
                                        name: e.key,
                                        value: e.value,
                                        color: character.color))
                                    .toList(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: {
                                  "Kills/Round": character.killsRound,
                                  "Aces": character.aces,
                                  "Most Kills": character.mostKills,
                                }
                                    .entries
                                    .map((e) => ExpandedTile(
                                        name: e.key,
                                        value: e.value,
                                        color: character.color))
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 1 / 2,
            child: Column(
              children: [
                Expanded(
                  child: MyCard(
                    color: character.rankColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("RATING"),
                        SizedBox(
                          height: 64,
                          width: 64,
                          child: Image.asset(character.rank),
                        ),
                        Text(
                          "DIAMOND 1",
                          style: style.bodySmall!
                              .copyWith(color: scheme.onSurface),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: MyCard(
                    color: character.weaponColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("TOP WEAPON"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            height: 64,
                            child: Image.asset(
                              character.weapon,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: character.weaponName,
                            style: style.caption!
                                .copyWith(color: scheme.onSurface),
                            children: [
                              const WidgetSpan(child: SizedBox(width: 4)),
                              TextSpan(
                                text: "Assault Rifles",
                                style: style.bodySmall!.copyWith(fontSize: 10),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RadialBar extends StatefulWidget {
  const RadialBar({
    Key? key,
    required this.value,
  }) : super(key: key);

  final double value;

  @override
  State<RadialBar> createState() => _RadialBarState();
}

class _RadialBarState extends State<RadialBar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    value = widget.value;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    final curve = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    animation = Tween<double>(begin: 0, end: widget.value).animate(curve)..addListener(() {
      setState(() {
        
      });
    });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

 late double value;

  @override
  Widget build(BuildContext context) {
    if(value!=widget.value){
      value = widget.value;
      controller.repeat();
      controller.forward();
    }
    return CustomPaint(
      painter: ProgressClipper(widget.value * animation.value),
      child: const SizedBox(),
    );
  }
}

class ExpandedTile extends StatelessWidget {
  const ExpandedTile(
      {Key? key, required this.name, required this.value, required this.color})
      : super(key: key);
  final String name;
  final String value;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    return Expanded(
      child: TileCard(
        color: color,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                name,
                style: style.bodySmall!.copyWith(fontSize: 10),
              ),
              Text(
                value,
                style: style.bodyLarge!.copyWith(fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
