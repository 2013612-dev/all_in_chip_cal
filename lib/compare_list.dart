import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CompareList extends StatelessWidget {
  const CompareList({
    super.key,
    required this.index,
    required this.options,
    required this.street,
    required this.onChanged,
    required this.onDelete,
  });

  final int index;
  final List<DropdownMenuEntry<int>> options;
  final List<List<int>> street;
  final void Function(List<List<int>>) onChanged;
  final void Function() onDelete;

  List<List<int>> generateLevelList(List<int> playerIds, List<int> signs) {
    final list = List<List<int>>.empty(growable: true);
    for (final (index, value) in playerIds.indexed) {
      if (index == 0 || signs[index - 1] == 1) {
        list.add([value]);
      } else {
        list.last.add(value);
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final playerIds = List.filled(options.length, street[0][0]);
    final signs = List.filled(options.length - 1, 1);
    var index1 = 0;
    var index2 = 0;

    for (int i = 0; i < signs.length; i++) {
      if (index2 >= street[index1].length - 1) {
        index1++;
        index2 = 0;
        signs[i] = 1;
      } else {
        index2++;
        signs[i] = 0;
      }
      playerIds[i + 1] = street[index1][index2];
    }

    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Text("Street $index"),
          const SizedBox(width: 8),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) => DropdownButtonHideUnderline(
                child: DropdownButton2<int>(
                  items: options
                      .map((item) => DropdownMenuItem<int>(
                    value: item.value,
                    child: Text(
                      item.label,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                      .toList(),
                  value: playerIds[index],
                  onChanged: (value) {
                    final newIndex = playerIds.indexOf(value!);
                    playerIds.swap(index, newIndex);
                    onChanged(generateLevelList(playerIds, signs));
                  },
                  buttonStyleData: const ButtonStyleData(
                    height: 40,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                ),
              )),
              separatorBuilder: (context, index) => IconButton(
                onPressed: () {
                  signs[index] = 1 - signs[index];
                  onChanged(generateLevelList(playerIds, signs));
                },
                icon: Text(signs[index] == 0 ? '=' : '>'),
              ),
              itemCount: options.length,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.cancel),
          ),
        ],
      ),);
  }
}
