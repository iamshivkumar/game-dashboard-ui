import 'package:flutter/material.dart';

import '../../utils/data.dart';
import '../../utils/pallate.dart';
import 'my_card.dart';
import 'tile_card.dart';

class LastMachesView extends StatelessWidget {
  const LastMachesView({
    Key? key,
    required this.color
  }) : super(key: key);
   final Color color;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    return MyCard(
      light: true,
      color: color,
      child: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("LAST MATCH",style: style.titleMedium,),
                Text(
                  "View All Matches",
                  style: style.bodySmall!.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
              child: Row(
                children: [
                  Container(
                    width: 1,
                    color: scheme.surfaceVariant,
                  ),
                  Expanded(
                    child: ListView(
                      children: Data.macthes.entries
                          .map(
                            (e) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(e.key),
                                    ),
                                    if (e.key == "TODAY")
                                      Container(
                                        height: 4,
                                        width: 4,
                                        color: Pallate.teal,
                                      )
                                  ],
                                ),
                                ...e.value
                                    .map(
                                      (v) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: TileCard(
                                          color: v.win > v.lose
                                              ? Pallate.teal
                                              : Pallate.red,
                                          child: SizedBox(
                                            height: 56,
                                            child: Row(
                                              children: [
                                                AspectRatio(
                                                  aspectRatio: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          AssetImage(v.image),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        v.name,
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      RichText(
                                                        text: TextSpan(
                                                            text: "${v.win}",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Pallate.teal,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text: " : ",
                                                                style: style
                                                                    .bodySmall,
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    "${v.lose}",
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Pallate
                                                                        .red),
                                                              ),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "K/D/A",
                                                        style: style.bodySmall,
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        "${v.k}/${v.d}/${v.a}",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                AspectRatio(
                                                  aspectRatio: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Image.asset(v.rank),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList()
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
