import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category {
  final int categoryId;
  final String name;
  final IconData icon;

  Category({this.categoryId, this.name, this.icon});
}

final allCategory = Category(
  categoryId: 0,
  name: "All",
  icon: Icons.search,
);

final musicCategory = Category(
  categoryId: 1,
  name: "Group",
  icon: Icons.group,
);

final meetUpCategory = Category(
  categoryId: 2,
  name: "Solo",
  icon: Icons.person,
);

final golfCategory = Category(
  categoryId: 3,
  name: "Meetup",
  icon: Icons.location_on,
);

final birthdayCategory = Category(
  categoryId: 4,
  name: "Foods",
  icon: Icons.fastfood,
);

final categories = [
  allCategory,
  musicCategory,
  meetUpCategory,
  golfCategory,
  birthdayCategory,
];