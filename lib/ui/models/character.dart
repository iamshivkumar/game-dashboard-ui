import 'package:flutter/material.dart';

class GameCharacter {
  final String name;
  final String image;
  final Color color;
  final String hours;
  final String kdRatio;
  final String dmgRound;
  final List<String> ability;
  final int wins;
  final int lose;
  final String kills;
  final String headshots;
  final String deaths;
  final String killsRound;
  final String aces;
  final String mostKills;
  final String rank;
  final Color rankColor;
  final String weapon;
  final String weaponName;
  final Color weaponColor;
  
  double get winRatio => (wins / (lose + wins));
  String get winRate => (winRatio * 100).toStringAsFixed(1);

  GameCharacter({
    required this.weaponName,
    required this.name,
    required this.image,
    required this.color,
    required this.hours,
    required this.kdRatio,
    required this.dmgRound,
    required this.ability,
    required this.wins,
    required this.lose,
    required this.kills,
    required this.headshots,
    required this.deaths,
    required this.killsRound,
    required this.aces,
    required this.mostKills,
    required this.rank,
    required this.rankColor,
    required this.weapon,
    required this.weaponColor,
  });
}
