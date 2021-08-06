import 'package:flutter/material.dart';
import 'package:flutter_ig/enums/bottom_nav_item.dart';
import 'package:flutter_ig/enums/enums.dart';

class BottomNavBar extends StatelessWidget {
  final Map<BottomNavItem, IconData> items;
  final BottomNavItem selectedItem;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // set the space between icons
      backgroundColor: Colors.white,
      showSelectedLabels: false, //emphasize the selected
      showUnselectedLabels: false, //unemphasize the unselected
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      currentIndex: BottomNavItem.values.indexOf(selectedItem),
      onTap: onTap,
      items: items
          .map((item, icon) => MapEntry(
                item.toString(),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(icon, size: 30.0),
                ),
              ))
          .values
          .toList(),
    );
  }
}
