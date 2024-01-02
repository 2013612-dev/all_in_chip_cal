import 'package:all_in_chip_cal/player.dart';
import 'package:all_in_chip_cal/player_tile.dart';
import 'package:flutter/material.dart';

import 'compare_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'All in Chip Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Player> playerList = List.empty(growable: true);
  int count = 2;

  @override
  void initState() {
    playerList.add(Player(id: 0, name: 'a', chip: 15000));
    playerList.add(Player(id: 1, name: 'b', chip: 10000));
    super.initState();
  }

  void _addPlayer() {
    setState(() {
      playerList.add(Player(id: count, name: count.toString(), chip: 3000));
      count++;
    });
  }

  void _removePlayer(int index) {
    if (playerList.length > 2) {
      setState(() {
        playerList.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: playerList.length + 1,
          itemBuilder: (context, index) {
            if (index == playerList.length) {
              return OutlinedButton.icon(
                onPressed: _addPlayer,
                icon: const Icon(Icons.add),
                label: const SizedBox.shrink(),
              );
            }

            return PlayerTile(
              key: Key(playerList[index].id.toString()),
              index: index + 1,
              player: playerList[index],
              onDelete: () {
                _removePlayer(index);
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 8,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CompareScreen(playerList: playerList),
            ),
          );
        },
        child: const Icon(Icons.arrow_right_alt),
      ),
    );
  }
}
