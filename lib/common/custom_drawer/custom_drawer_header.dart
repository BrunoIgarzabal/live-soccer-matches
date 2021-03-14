import 'package:flutter/material.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'TREX',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  'Lorem ipsum dolor sit amet.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ),
              Expanded(child: IconButton(icon: Icon(Icons.settings), onPressed: () {

              }))
            ],
          )
        ],
      ),
    );
  }
}
