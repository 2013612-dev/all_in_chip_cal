import 'package:all_in_chip_cal/player.dart';
import 'package:flutter/material.dart';

import 'compare_list.dart';
import 'helper.dart';

class CompareScreen extends StatefulWidget {
  const CompareScreen({super.key, required this.playerList});

  final List<Player> playerList;

  @override
  State<StatefulWidget> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  final List<List<List<int>>> streetList = List.empty(growable: true);
  late List<DropdownMenuEntry<int>> optionList;

  @override
  void initState() {
    _addStreet();
    optionList = widget.playerList
        .map((e) => DropdownMenuEntry(value: e.id, label: e.name))
        .toList();
    super.initState();
  }

  void _addStreet() {
    setState(() {
      streetList.add(
        widget.playerList
            .map(
              (element) => List.filled(
            1,
            element.id,
          ),
        )
            .toList(),
      );
    });
  }

  void _deleteStreet(int index) {
    if (streetList.length > 1) {
      setState(() {
        streetList.removeAt(index);
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Compare Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: streetList.length + 1,
              itemBuilder: (context, index) {
                if (index == streetList.length) {
                  return OutlinedButton.icon(
                    onPressed: _addStreet,
                    icon: const Icon(Icons.add),
                    label: const SizedBox.shrink(),
                  );
                }

                return CompareList(
                  key: Key(index.toString()),
                  index: index + 1,
                  options: optionList,
                  street: streetList[index],
                  onChanged: (street) => setState(() {
                    streetList[index] = street;
                  }),
                  onDelete: () => _deleteStreet(index),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 8,
                );
              },
            ),
            const SizedBox(height: 12,),
            ...chipDistribution(widget.playerList, streetList).map((e) => Text("${e.name}: ${e.chip.toInt()}", style: const TextStyle(fontSize: 24),),),
          ],
        ),
      ),
    );
  }
}


