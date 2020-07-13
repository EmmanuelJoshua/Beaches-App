import 'package:animatingpagetransition/utils/title.dart';
import 'package:animatingpagetransition/widgets/actionrows.dart';
import 'package:animatingpagetransition/widgets/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../theme.dart';
import '../viewstate.dart';

class BeachScreen extends StatefulWidget {
//  final String beachImage;
  final int beachId;

  BeachScreen({Key key, this.beachId});

  @override
  _BeachScreenState createState() => _BeachScreenState();
}

class _BeachScreenState extends State<BeachScreen> {
  Map<int, Map<String, String>> beaches = {
    0: {'beachName': 'Miami', 'beachImage': 'assets/images/beach1.jpg'},
    1: {'beachName': 'Rio', 'beachImage': 'assets/images/beach2.jpg'},
    2: {'beachName': 'Ca. USA', 'beachImage': 'assets/images/beach3.jpg'},
    3: {'beachName': 'Mexico', 'beachImage': 'assets/images/beach1.jpg'},
    4: {'beachName': 'Toronto', 'beachImage': 'assets/images/beach2.jpg'}
  };

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: IconButton(
              icon: Icon(LineIcons.angle_left, color: Color(0xFF1A201A)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(LineIcons.arrow_circle_o_up, color: Color(0xFF1A201A)),
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: IconButton(
                icon: Icon(LineIcons.search, color: Color(0xFF1A201A)),
                onPressed: () {},
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFFFCFDFD),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                Hero(
                  tag: 'beaches',
                  child: Header(
                    viewState: ViewState.shrunk,
                  ),
                )
              ],
            ),
//            Padding(padding: const EdgeInsets.all(19),),
            Container(
              width: deviceSize.width,
              padding: const EdgeInsets.only(right: 30),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 28, bottom: 23),
                    child: Hero(
                      tag: 'image${beaches.keys.elementAt(widget.beachId)}',
                      child: Image.asset(
                        beaches[widget.beachId]['beachImage'],
                        width: deviceSize.width,
                        height: 250,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton(
                      heroTag: 'beach${widget.beachId}',
                      backgroundColor: Color(0xFF010101),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0))),
                      onPressed: () {},
                      child: Icon(Icons.add),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Hero(
                        tag: 'title${widget.beachId}',
                        child: DestinationTitle(
                          title: beaches[widget.beachId]['beachName'],
                          viewState: ViewState.enlarged,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 30),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Deleniti quia vero, explicabo illum, debitis nihil odio',
                style: descriptiontext,
              ),
            ),
            Padding(
            padding: const EdgeInsets.all(8.0)),
            ActionRows(),

          ],
        ));
  }
}
