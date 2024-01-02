import 'package:all_in_chip_cal/helper.dart';
import 'package:all_in_chip_cal/player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Single Street, Single Tier', () {
    final playerList = [Player(id: 1, name: 'Alice', chip: 4), Player(id: 2, name: 'Bob', chip: 2)];
    final streetList = [[ [1, 2] ]];
    expect(chipDistribution(playerList, streetList).toString(), [Player(id: 1, name: 'Alice', chip: 4), Player(id: 2, name: 'Bob', chip: 2)].toString());
  });

  test('Single Street, Multiple Tiers', () {
    final playerList = [Player(id: 1, name: 'Alice', chip: 6), Player(id: 2, name: 'Bob', chip: 3), Player(id: 3, name: 'Charlie', chip: 1)];
    final streetList = [[ [1], [2, 3] ]];
    expect(chipDistribution(playerList, streetList).toString(), [Player(id: 1, name: 'Alice', chip: 10), Player(id: 2, name: 'Bob', chip: 0), Player(id: 3, name: 'Charlie', chip: 0)].toString());
  });

  test('Multiple Streets', () {
    final playerList = [Player(id: 1, name: 'Alice', chip: 12), Player(id: 2, name: 'Bob', chip: 8), Player(id: 3, name: 'Charlie', chip: 8), Player(id: 4, name: 'David', chip: 4)];
    final streetList = [[ [1, 2], [3, 4] ], [ [2, 3], [1, 4] ]];
    expect(chipDistribution(playerList, streetList).toString(), [Player(id: 1, name: 'Alice', chip: 11), Player(id: 2, name: 'Bob', chip: 14), Player(id: 3, name: 'Charlie', chip: 7), Player(id: 4, name: 'David', chip: 0)].toString());
  });

  test('Player with 0 Initial Chip', () {
    final playerList = [Player(id: 1, name: 'Alice', chip: 4), Player(id: 2, name: 'Bob', chip: 0)];
    final streetList = [[ [1, 2] ]];
    expect(chipDistribution(playerList, streetList).toString(), [Player(id: 1, name: 'Alice', chip: 4), Player(id: 2, name: 'Bob', chip: 0)].toString());
  });
}