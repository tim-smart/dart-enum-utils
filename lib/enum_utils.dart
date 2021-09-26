library enum_utils;

import 'package:fpdart/fpdart.dart';

String _id<T>(T val) => val.toString().split('.')[1].toLowerCase();

String Function(T) id<T>() => _id;

Map<String, T> idMap<T>(List<T> values) =>
    values.fold({}, (acc, val) => {...acc, _id(val): val});

Option<T> Function(V) fromMap<T, V>(Map<T, V> map) {
  final reverseMap = map.entries.fold<Map<V, T>>(
    {},
    (acc, entry) => {
      ...acc,
      entry.value: entry.key,
    },
  );

  return (key) => optionOf(reverseMap[key]);
}

Option<T> Function(String) fromId<T>(List<T> values) {
  final map = idMap(values);
  return (id) => optionOf(map[id]);
}

V Function(T) valueMap<T, V>(Map<T, V> map, V Function() dflt) =>
    (T val) => optionOf(map[val]).getOrElse(dflt);

Option<V> Function(T) optionValueMap<T, V>(Map<T, V> map) =>
    (T val) => optionOf(map[val]);
