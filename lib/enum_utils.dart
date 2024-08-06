library enum_utils;

import 'package:elemental/elemental.dart';

Map<String, T> nameMap<T extends Enum>(List<T> values) =>
    values.fold({}, (acc, val) => {...acc, val.name: val});

Option<T> Function(String) fromName<T extends Enum>(List<T> values) {
  final map = nameMap(values);
  return (id) => Option.fromNullable(map[id]);
}

T? Function(String) fromNameOrNull<T extends Enum>(List<T> values) {
  final map = nameMap(values);
  return (id) => map[id];
}

T Function(String) fromNameOrElse<T extends Enum>(List<T> values, T dflt) {
  final map = nameMap(values);
  return (id) => map[id] ?? dflt;
}
