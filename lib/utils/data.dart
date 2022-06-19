import 'package:flutter/material.dart';
import 'package:game_dashboard/ui/models/character.dart';
import 'package:game_dashboard/utils/assets.dart';
import 'package:game_dashboard/utils/pallate.dart';

import '../ui/models/match.dart';

class MatchNames {
  static const String icebox = "ICEBOX";
  static const String brezze = "BREZZE";
  static const String ascent = "ASCENT";
  static const String bind = "BIND";
  static const String split = "SPLIT";
}

class Data {
  static List<GameCharacter> characters = [
    GameCharacter(
      name: "OMEN",
      image: Assets.omen,
      weaponName: "VANDAL",
      color: Colors.blueAccent,
      hours: "358H 46M",
      kdRatio: "1.14",
      dmgRound: "138.2",
      ability: ["0.33", "0.78", "4.82"],
      wins: 925,
      lose: 250,
      kills: "12,626",
      headshots: "7,120",
      deaths: "11,232",
      killsRound: "0.8",
      aces: "23",
      mostKills: "11,232",
      rank: Assets.rank1,
      rankColor: Colors.yellow,
      weapon: Assets.weapon1,
      weaponColor: Colors.yellow,
    ),
    GameCharacter(
      name: "JETT",
      image: Assets.jett,
      color: Colors.cyan,
      weaponName: "Beretta",
      hours: "336H 11M",
      kdRatio: "1.22",
      dmgRound: "150.2",
      ability: ["0.27", "0.68", "3.28"],
      wins: 725,
      lose: 328,
      kills: "11,416",
      headshots: "6,139",
      deaths: "12,432",
      killsRound: "0.4",
      aces: "30",
      mostKills: "10,323",
      rank: Assets.rank2,
      rankColor: Colors.purpleAccent,
      weapon: Assets.weapon2,
      weaponColor: Colors.brown,
    ),
    GameCharacter(
      name: "REYNA",
      weaponName: "ArmaLite",
      image: Assets.reyna,
      color: Colors.purpleAccent,
      hours: "322H 42M",
      kdRatio: "1.18",
      dmgRound: "140.9",
      ability: ["0.26", "0.78", "3.14"],
      wins: 601,
      lose: 365,
      kills: "15,614",
      headshots: "5,239",
      deaths: "11,234",
      killsRound: "0.6",
      aces: "26",
      mostKills: "9,232",
      rank: Assets.rank3,
      rankColor: Colors.brown.shade300,
      weapon: Assets.weapon3,
      weaponColor: Colors.pinkAccent,
    ),
  ];

  static Map<String, List<GameMatch>> get macthes => {
        "TODAY": [
          GameMatch(
            image: Assets.profile1,
            name: MatchNames.icebox,
            win: 12,
            lose: 8,
            k: "12",
            d: "8",
            a: "20",
            rank: Assets.rank1,
          ),
          GameMatch(
            image: Assets.profile2,
            name: MatchNames.brezze,
            win: 9,
            lose: 8,
            k: "12",
            d: "15",
            a: "11",
            rank: Assets.rank2,
          ),
          GameMatch(
            image: Assets.profile3,
            name: MatchNames.icebox,
            win: 11,
            lose: 6,
            k: "12",
            d: "22",
            a: "11",
            rank: Assets.rank2,
          ),
          GameMatch(
            image: Assets.profile4,
            name: MatchNames.ascent,
            win: 8,
            lose: 10,
            k: "8",
            d: "22",
            a: "11",
            rank: Assets.rank3,
          ),
        ],
        "27 JUNE": [
          GameMatch(
            image: Assets.profile1,
            name: MatchNames.bind,
            win: 15,
            lose: 10,
            k: "8",
            d: "22",
            a: "11",
            rank: Assets.rank2,
          ),
          GameMatch(
            image: Assets.profile2,
            name: MatchNames.split,
            win: 9,
            lose: 11,
            k: "18",
            d: "22",
            a: "11",
            rank: Assets.rank3,
          ),
          GameMatch(
            image: Assets.profile4,
            name: MatchNames.icebox,
            win: 6,
            lose: 1,
            k: "7",
            d: "22",
            a: "11",
            rank: Assets.rank2,
          ),
          GameMatch(
            image: Assets.profile3,
            name: MatchNames.ascent,
            win: 17,
            lose: 7,
            k: "7",
            d: "22",
            a: "11",
            rank: Assets.rank1,
          ),
        ]
      };
}
