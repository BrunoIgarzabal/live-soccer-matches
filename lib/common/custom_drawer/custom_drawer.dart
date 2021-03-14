import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:soccer_app/common/custom_drawer/custom_drawer_header.dart';
import 'package:soccer_app/common/custom_drawer/drawer_subtitle.dart';
import 'package:soccer_app/common/custom_drawer/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
          ),
          ListView(
            children: [
              CustomDrawerHeader(),
              const Divider(),
              DrawerSubtitle(title: 'POPULAR SPORTS',),
              DrawerTile(
                iconData: Icons.error,
                title: 'Item 1',
                page: 0,
              ),
              DrawerTile(
                iconData: Icons.error,
                title: 'Item 2',
                page: 1,
              ),
              DrawerTile(
                iconData: Icons.error,
                title: 'Item 3',
                page: 1,
              ),
              DrawerSubtitle(title: 'OTHER SPORTS',),
              DrawerTile(
                iconData: Icons.error,
                title: 'Item 4',
                page: 2,
              ),
              DrawerTile(
                iconData: Icons.error,
                title: 'Item 5',
                page: 2,
              ),

            ],
          )
        ],
      ),
    );
  }
}
