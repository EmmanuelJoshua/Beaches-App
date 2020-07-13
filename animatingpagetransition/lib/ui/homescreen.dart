import 'package:animatingpagetransition/theme.dart';
import 'package:animatingpagetransition/ui/beachscreen.dart';
import 'package:animatingpagetransition/utils/fadepageroute.dart';
import 'package:animatingpagetransition/utils/title.dart';
import 'package:animatingpagetransition/widgets/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../viewstate.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          padding: const EdgeInsets.only(left: 10),
          child: Icon(LineIcons.bars, color: Color(0xFF1A201A)),
        ),
        elevation: 0,
        actions: [
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
                flightShuttleBuilder: (
                  BuildContext flightContext,
                  Animation<double> animation,
                  HeroFlightDirection flightDirection,
                  BuildContext fromHeroContext,
                  BuildContext toHeroContext,
                ) {
                  return Header(
                    viewState: flightDirection == HeroFlightDirection.push
                        ? ViewState.shrink
                        : ViewState.enlarge,
                    smallFontSize: 20.0,
                    largeFontSize: 32.0,
                    smallIconSize: 24.0,
                    largeIconSize: 0.0,
                  );
                },
                child: Header(
                  viewState: ViewState.enlarged,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(3),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                LineIcons.angle_down,
                size: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(4),
              ),
              Text(
                'Most Visited',
                style: sorttext,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 5),
            width: deviceSize.width,
            height: 400,
            child: BeachList(beaches: beaches),
          )
        ],
      ),
    );
  }
}

class BeachList extends StatelessWidget {
  const BeachList({
    Key key,
    @required this.beaches,
  }) : super(key: key);

  final Map<int, Map<String, String>> beaches;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 25, right: 16),
      itemCount: beaches.keys.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            var router = FadePageRoute(
                fullscreenDialog: true,
                builder: (BuildContext context) =>
                    BeachScreen(beachId: beaches.keys.elementAt(index)));
            Navigator.of(context).push(router);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Container(
                  width: 70,
                  child: Hero(
                    tag: 'title${beaches.keys.elementAt(index)}',
                    flightShuttleBuilder: (
                        BuildContext flightContext,
                        Animation<double> animation,
                        HeroFlightDirection flightDirection,
                        BuildContext fromHeroContext,
                        BuildContext toHeroContext,
                        ) {
                      return DestinationTitle(
                        title:  beaches[index]['beachName'],
                        isOverflow: true,
                        viewState: flightDirection == HeroFlightDirection.push
                            ? ViewState.enlarge
                            : ViewState.shrink,
                        smallFontSize: 15.0,
                        largeFontSize: 32.0,
                      );
                    },
                    child: DestinationTitle(
                      title:  beaches[index]['beachName'],
                      viewState: ViewState.shrunk,
                    ),
                  ),
                ),
                Expanded(
                  child: Hero(
                    tag: 'image${beaches.keys.elementAt(index)}',
                    child: Image.asset(
                      beaches[index]['beachImage'],
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                FloatingActionButton(
                  heroTag: 'beach${beaches.keys.elementAt(index)}',
                  backgroundColor: Color(0xFF010101),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                  onPressed: () {},
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
