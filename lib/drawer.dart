import 'package:flutter/material.dart';
import 'package:foodboard_admin_application/addRecipe/admin_login.dart';
import 'package:foodboard_admin_application/utils/colors.dart';

class MyDrawer extends StatelessWidget {
  final Function setIndex;
  final int selectedIndex;
  const MyDrawer({
    Key? key,
    required this.selectedIndex,
    required this.setIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.greyShade,
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Container(
                height: 135,
                width: 135,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey.shade50),
                  borderRadius: BorderRadius.circular(100), //<-- SEE HERE
                ),
                child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/Logo.png"),
                ),
              ),
            ),
          ),
          _navItem(context, Icons.person, 'HomePage', onTap: () {
            _navItemClicked(context, 0);
          }, selected: selectedIndex == 0),
          _navItem(context, Icons.add_circle_outline_outlined, 'Add New Recipe',
              onTap: () {
            _navItemClicked(context, 1);
          }, selected: selectedIndex == 1),
          _navItem(context, Icons.person, 'None', onTap: () {
            _navItemClicked(context, 2);
          }, selected: selectedIndex == 2),
          _navItem(context, Icons.person, 'SignOut', onTap: () {
            // _navItemClicked(context, 3);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Admin_Login()));
          }, selected: selectedIndex == 3),
          _navItem(context, Icons.person, 'Add Another Admin', onTap: () {
            _navItemClicked(context, 4);
          }, selected: selectedIndex == 4),
        ],
      ),
    );
  }

  _navItem(BuildContext context, IconData icon, String text,
          {Text? suffix, required VoidCallback onTap, bool selected = false}) =>
      Container(
        color: selected ? AppColors.oceanShade : Colors.transparent,
        child: ListTile(
          leading: Icon(icon,
              color: selected ? Theme.of(context).primaryColor : Colors.black),
          trailing: suffix,
          title: Text(text),
          selected: selected,
          onTap: onTap,
        ),
      );

  _navItemClicked(BuildContext context, int index) {
    setIndex(index);
    Navigator.of(context).pop();
  }
}
