import 'package:all_in_chip_cal/player.dart';
import 'package:flutter/material.dart';

class PlayerTile extends StatefulWidget {
  const PlayerTile({
    super.key,
    required this.index,
    required this.player,
    required this.onDelete,
  });

  final int index;
  final Player player;
  final void Function() onDelete;

  @override
  State<PlayerTile> createState() => _PlayerTileState();
}

class _PlayerTileState extends State<PlayerTile> {
  final nameController = TextEditingController();
  final chipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.player.name;
    chipController.text = widget.player.chip.toInt().toString();
    nameController.addListener(() {
      widget.player.name = nameController.text;
    });
    chipController.addListener(() {
      widget.player.chip = double.tryParse(chipController.text) ?? 0;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    chipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Player ${widget.index}"),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'name',
              isDense: true,
              contentPadding: EdgeInsets.all(12.0),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: TextField(
            controller: chipController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'chip',
              isDense: true,
              contentPadding: EdgeInsets.all(12.0),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        IconButton(
          onPressed: widget.onDelete,
          icon: const Icon(Icons.cancel),
        ),
      ],
    );
  }
}
