import "dart:io";

import "package:path/path.dart" as paths;
import "package:stoat/src/functors.dart";
import "package:stoat/src/models.dart";
import "package:stoat/src/shared.dart";

class DefinitionsParser {
  static late Map<String, Map<String, DefinitionFunctor<dynamic>>>
      _sharedChildDefinitionFunctors;

  static void prepare() {
    _sharedChildDefinitionFunctors = <String, Map<String, DefinitionFunctor<dynamic>>>{
      "str": <String, DefinitionFunctor<String>>{"_": DefaultDefinitionFunctor()},
      "list": <String, DefinitionFunctor<List<dynamic>>>{
        "str": ListStringDefinitionFunctor(),
        "double": ListDoubleDefinitionFunctor(),
        "int": ListIntegerDefinitionFunctor(),
      },
      "double": <String, DefinitionFunctor<double>>{"_": DoubleDefinitionFunctor()},
      "int": <String, DefinitionFunctor<int>>{"_": IntegerDefinitionFunctor()}
    };
  }

  static void dispose() {
    _sharedChildDefinitionFunctors.clear();
  }

  static const String _beginSeparatorToken = r"\{";
  static const String _endSeparatorToken = r"\}";
  static const String _lineSeparatorToken = ";";
  static final RegExp _separators =
      RegExp("$_beginSeparatorToken${r"(.*?)"}$_endSeparatorToken", dotAll: true);

  static List<DefinitionNode> parse(String content) {
    List<DefinitionNode> trees = <DefinitionNode>[];
    for (RegExpMatch match in _separators.allMatches(content)) {
      String content = match.group(1)!.trim();
      List<String> lines = Shared.parseNSplitListPattern(content, _lineSeparatorToken)
          .map((String line) => line.trim())
          .toList()
        ..removeWhere((String line) => line.isEmpty);
      if (lines.isNotEmpty && lines[0].isNotEmpty) {
        String key = lines.first;
        DefinitionNode rootNode = DefinitionNode(key);
        for (int i = 1; i < lines.length; i++) {
          if (lines[i].isNotEmpty) {
            List<String> parts = lines[i].split(" ");
            String name = parts.first.split("::").first;
            if (!Shared.isValidKey(name)) {
              throw DefinitionsFileParserError("Invalid child name: $name",
                  "Child names can only contain alphanumeric letters and underscores.");
            }
            // TODO: implement typing and lookup for functors
            if (parts.length <= 1) {
              throw DefinitionsFileParserError(
                  "Unexpected empty definition child",
                  "$key\n\t└── ${lines[i]}\n\t\t└── null",
                  'Either delete or assign a value to child ${lines[i]}');
            }
            String value = parts.sublist(1).join(" ");
            rootNode.addChild(DefinitionEntry(name, value));
          }
        }
        trees.add(rootNode);
      } else {
        throw DefinitionsFileParserError(
            "Unexpected empty definition.", "After:\n${trees.last}");
      }
    }
    return trees;
  }

  static Future<List<DefinitionNode>> parseDefinitionsFile(String filePath) async {
    String ext = paths.extension(filePath);
    if (!ext.equalsIgnoreCase(".df")) {
      throw DefinitionsFileParserError("Invalid file extension for definitions file",
          "$filePath [$ext] =/= '.df' or '.DF'");
    }
    File file = File(filePath);
    if (!await file.exists()) {
      throw DefinitionsFileParserError(
          "Input definitions file does not exist.", filePath);
    }
    return parse(await file.readAsString());
  }
}
