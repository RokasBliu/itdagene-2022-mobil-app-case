enum KeyType {
  letter,
  enter,
  backspace,
}

class KeyboardKey {
  final String symbol;
  final String semantic;
  final KeyType type;

  const KeyboardKey(this.symbol, this.semantic, this.type);
}
