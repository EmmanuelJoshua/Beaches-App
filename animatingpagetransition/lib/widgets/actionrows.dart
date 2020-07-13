import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ActionRows extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.location_on,
            color: Colors.black,
            size: 24.0,
          ),
          SizedBox(
            width: 24.0,
          ),
          Icon(
            LineIcons.flag_o,
            color: Colors.black,
            size: 24.0,
          ),
          SizedBox(
            width: 24.0,
          ),
          Icon(
            LineIcons.rotate_left,
            color: Colors.black,
            size: 24.0,
          ),
          SizedBox(
            width: 24.0,
          ),
          Text(
            'More',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          )
        ],
      ),
    );
  }
}
