import 'dart:collection';
import 'dart:math';

import 'package:all_in_chip_cal/player.dart';
import 'package:collection/collection.dart';

List<Player> chipDistribution(List<Player> playerList, List<List<List<int>>> streetList) {
  final playersChip = _createPlayerChipLookup(playerList);
  final resultChip = _createInitialResultList(playerList);

  for (final street in streetList) {
    final sortedTiers = _createSortedTiers(street, playersChip);

    for (int i = 0; i < sortedTiers.length; i++) {
      while (sortedTiers[i].isNotEmpty) {
        double chipSum = _getEffectChips(sortedTiers, sortedTiers[i].last.chip);
        for (final player in sortedTiers[i]) {
          final target = resultChip.firstWhere((element) => element.id == player.id);
          target.chip += chipSum / sortedTiers[i].length;
        }
        sortedTiers[i].removeLast();
      }
    }
  }
  for (final player in resultChip) {
    player.chip = player.chip / streetList.length;
  }
  return resultChip;
}

HashMap<int, double> _createPlayerChipLookup(List<Player> players) {
  return HashMap<int, double>.fromIterable(players,
      key: (player) => player.id, value: (player) => player.chip);
}

List<Player> _createInitialResultList(List<Player> players) {
  return players.map((player) => Player(
    id: player.id,
    name: player.name,
    chip: 0,
  )).toList();
}

List<List<Player>> _createSortedTiers(List<List<int>> street, HashMap<int, double> playersChips) {
  return street.map((tier) => tier
      .map((id) => Player(
    id: id,
    name: '',
    chip: playersChips[id] ?? 0,
  ))
      .sortedByCompare((player) => player.chip, (a, b) => (b - a).ceil()))
      .toList();
}

double _getEffectChips(List<List<Player>> sortedTiers, double targetChip) {
  double chipSum = 0;
  for (final tier in sortedTiers) {
    for (final player in tier) {
      final effectiveChip = min(targetChip, player.chip);
      chipSum += effectiveChip;
      player.chip -= effectiveChip;
    }
  }
  return chipSum;
}