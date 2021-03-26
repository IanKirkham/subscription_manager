import 'package:flutter/material.dart';

class ListItem {
  String name;
  Icon icon;

  ListItem({
    @required this.name,
    @required this.icon,
  });

  bool isEqual(ListItem model) {
    return this?.name == model?.name;
  }

  @override
  String toString() => name;
}
