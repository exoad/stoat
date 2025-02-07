extension StringUtils on String {
  /// Very ineffecient case insensistive checking.
  bool equalsIgnoreCase(String? other) {
    return other != null && this == other;
  }
}

class DefinitionsFileParserError implements Exception {
  final String message;
  final String? internal;
  final String? help;

  const DefinitionsFileParserError(this.message, [this.internal, this.help]);

  @override
  String toString() {
    StringBuffer buffer = StringBuffer("\n\n");
    for (int i = 0; i < 32; i++) {
      buffer.write("◢◤");
    }
    buffer.write("\n\n\t$message");
    if (internal != null) {
      buffer.write("\n\n");
      for (String r in internal!.split("\n")) {
        buffer.write("\t$r\n");
      }
    }
    if (help != null) {
      buffer.write("\n\tHelp: $help\n");
    }
    for (int i = 0; i < 32; i++) {
      buffer.write("◢◤");
    }
    buffer.write("\n\n");
    return buffer.toString();
  }
}

class Shared {
  Shared._();

  static List<String> parseNSplitListPattern(String input, [String delimiter = ","]) {
    return input
        .split(RegExp("${r"(?<!\\)"}$delimiter"))
        .map((String token) => token.replaceAll("\\$delimiter", delimiter))
        .toList();
  }

  /// Call [parseNSplitListPattern] before calling this method
  static List<String> cleanListPattern(List<String> parsed) {
    for (int i = 0; i < parsed.length; i++) {
      parsed[i].trim();
    }
    return parsed;
  }

  static bool _isLetter(String char) {
    return (char.codeUnitAt(0) >= 'a'.codeUnitAt(0) &&
            char.codeUnitAt(0) <= 'z'.codeUnitAt(0)) ||
        (char.codeUnitAt(0) >= 'A'.codeUnitAt(0) &&
            char.codeUnitAt(0) <= 'Z'.codeUnitAt(0));
  }

  static bool _isDigit(String char) {
    return char.codeUnitAt(0) >= '0'.codeUnitAt(0) &&
        char.codeUnitAt(0) <= '9'.codeUnitAt(0);
  }

  static bool isValidKey(String name) {
    if (name.isEmpty) {
      return false;
    }

    if (!_isLetter(name[0]) && name[0] != '_') {
      return false;
    }

    for (int i = 1; i < name.length; i++) {
      if (!_isLetter(name[i]) && !_isDigit(name[i]) && name[i] != '_') {
        return false;
      }
    }
    return true;
  }

  static String errorFormatter(String message, [String? internal, String? help]) {
    StringBuffer buffer = StringBuffer("\n\n");
    for (int i = 0; i < 32; i++) {
      buffer.write("◢◤");
    }
    buffer.write("\n\n\t$message");
    if (internal != null) {
      buffer.write("\n\n");
      for (String r in internal.split("\n")) {
        buffer.write("\t$r\n");
      }
    }
    if (help != null) {
      buffer.write("\n\tHelp: $help\n");
    }
    for (int i = 0; i < 32; i++) {
      buffer.write("◢◤");
    }
    buffer.write("\n\n");
    return buffer.toString();
  }
}
