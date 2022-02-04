library enum_utils;

import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart';

Map<String, T> nameMap<T extends Enum>(List<T> values) =>
    values.fold({}, (acc, val) => {...acc, val.name: val});

Option<T> Function(V) fromMap<T, V>(Map<T, V> map) {
  final reverseMap = map.entries.fold<Map<V, T>>(
    {},
    (acc, entry) => {
      ...acc,
      entry.value: entry.key,
    },
  );

  return (key) => fromNullable(reverseMap[key]);
}

Option<T> Function(String) fromName<T extends Enum>(List<T> values) {
  final map = nameMap(values);
  return (id) => fromNullable(map[id]);
}

T Function(String) fromNameOrElse<T extends Enum>(List<T> values, T dflt) {
  final map = nameMap(values);
  return (id) => map[id] ?? dflt;
}

V Function(T) valueMap<T, V>(Map<T, V> map, V Function() dflt) =>
    (T val) => fromNullable(map[val]).p(getOrElse(dflt));

Option<V> Function(T) optionValueMap<T, V>(Map<T, V> map) =>
    (T val) => fromNullable(map[val]);
