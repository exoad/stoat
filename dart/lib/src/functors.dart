import 'package:stoat/src/shared.dart';

abstract class DefinitionFunctor<R> {
  String get canonicalName;

  R call(String value);
}

class DefaultDefinitionFunctor implements DefinitionFunctor<String> {
  @override
  String call(String value) {
    return value;
  }

  @override
  String get canonicalName => "String";
}

class ListStringDefinitionFunctor implements DefinitionFunctor<List<String>> {
  @override
  List<String> call(String value) {
    List<String> res = <String>[];
    for (String r in Shared.parseNSplitListPattern(value)) {
      res.add(r);
    }
    return res;
  }

  @override
  String get canonicalName => "Strings List";
}

class DoubleDefinitionFunctor implements DefinitionFunctor<double> {
  @override
  double call(String value) {
    double? parsed = double.tryParse(value.trim());
    if (parsed == null) {
      throw DefinitionsFileParserError("Unexpect non-double type in $canonicalName",
          "$value is not parseable as 'double' in {$value}");
    }
    return parsed;
  }

  @override
  String get canonicalName => "Floating Point";
}

class IntegerDefinitionFunctor implements DefinitionFunctor<int> {
  @override
  int call(String value) {
    int? parsed = int.tryParse(value.trim());
    if (parsed == null) {
      throw DefinitionsFileParserError("Unexpect non-int type in $canonicalName",
          "$value is not parseable as 'int' in {$value}");
    }
    return parsed;
  }

  @override
  String get canonicalName => "Floating Point";
}

class ListDoubleDefinitionFunctor implements DefinitionFunctor<List<double>> {
  @override
  List<double> call(String value) {
    List<double> res = <double>[];
    for (String r in Shared.parseNSplitListPattern(value)) {
      double? parsed = double.tryParse(r.trim());
      if (parsed == null) {
        throw DefinitionsFileParserError("Unexpect non-double type in $canonicalName",
            "$r is not parseable as 'double' in {$value}");
      }
      res.add(parsed);
    }
    return res;
  }

  @override
  String get canonicalName => "Floating Point List";
}

class ListIntegerDefinitionFunctor implements DefinitionFunctor<List<int>> {
  @override
  List<int> call(String value) {
    List<int> res = <int>[];
    for (String r in Shared.parseNSplitListPattern(value)) {
      int? parsed = int.tryParse(r.trim());
      if (parsed == null) {
        throw DefinitionsFileParserError("Unexpect non-integer type in $canonicalName",
            "$r is not parseable as 'int' in {$value}");
      }
      res.add(parsed);
    }
    return res;
  }

  @override
  String get canonicalName => "Integer List";
}

