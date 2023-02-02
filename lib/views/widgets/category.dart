import 'package:flutter/material.dart';
import 'package:mr_baker/core/color.dart';

class CategoryMenu extends StatelessWidget {
  const CategoryMenu({
    Key? key,
    required this.categoryItem,
    required this.categoryPressed,
    required this.position,
    required this.selected,
  }) : super(key: key);
  final String categoryItem;
  final Function() categoryPressed;
  final int position;
  final int selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: categoryPressed,
      child: Container(
        margin: const EdgeInsets.only(right: 20.0),
        child: Text(
          categoryItem,
          style: TextStyle(
            fontSize: 17,
            color: (selected == position) ? orangeColor : blackColor,
          ),
        ),
      ),
    );
  }
}
