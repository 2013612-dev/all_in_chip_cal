class Player {
  final int id;
  String name;
  double chip;

  Player({required this.id, required this.name, required this.chip});

  @override
  String toString() {
    return 'id: $id name: $name chip: ${chip.toInt()}';
  }

  @override
  bool operator ==(Object other) {
    return super.toString() == other.toString();
  }

  @override
  int get hashCode => super.hashCode;
}
