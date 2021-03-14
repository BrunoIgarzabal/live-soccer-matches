import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  const DrawerTile({this.iconData, this.title, this.page});

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: Colors.white,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }
}
