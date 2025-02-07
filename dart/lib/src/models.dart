class DefinitionEntry {
  final String key;
  final dynamic value;

  const DefinitionEntry(this.key, this.value)
      : assert(value != null,
            "Definition Child's value cannot be null. Either set it to an empty string or give it a proper value.");

  @override
  String toString() {
    return "$key — $value";
  }
}


class DefinitionNode {
  String name;
  String? value;
  List<DefinitionEntry> children;

  DefinitionNode(this.name, {this.value, List<DefinitionEntry>? children})
      : children = children ?? <DefinitionEntry>[];

  void addChild(DefinitionEntry child) {
    children.add(child);
  }

  @override
  String toString() {
    final StringBuffer buffer = StringBuffer();
    _toStringHelper(buffer, "", true);
    return buffer.toString();
  }

  void _toStringHelper(StringBuffer buffer, String prefix, bool isLast) {
    buffer.write(prefix);
    buffer.write(isLast ? "└── " : "├── ");
    buffer.write(name);
    buffer.write("\n");
    for (int i = 0; i < children.length; i++) {
      buffer.write("    ${i == children.length - 1 ? "└── " : "├── "}${children[i]}\n");
    }
  }

  static String prettifyList(List<DefinitionNode> nodes) {
    StringBuffer buffer = StringBuffer("\n");
    for (DefinitionNode node in nodes) {
      buffer.write(node);
    }
    return buffer.toString();
  }
}