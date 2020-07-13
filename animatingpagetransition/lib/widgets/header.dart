import 'package:flutter/material.dart';
import 'package:animatingpagetransition/viewstate.dart';
import 'package:line_icons/line_icons.dart';

import '../theme.dart';

class HeaderContent extends StatelessWidget {
  final double iconSize;
  final double fontSize;
  final double textPadding;

  const HeaderContent({
    Key key,
    this.iconSize,
    this.fontSize,
    this.textPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 2.0,
            height: 50.0,
            color: Colors.transparent,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Container(
              height: 1.5,
              width: 19,
              color: Color(0xFFD1D1D3),
            ),
          ),
          Icon(LineIcons.sun_o, color: Color(0xFF010101), size: iconSize),
          Padding(
            padding: EdgeInsets.only(left: textPadding),
            child: Text('Beaches',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: fontSize,
                    color: primaryText,
                    fontWeight: FontWeight.w600)),
          )
        ],
      ),
    );
  }
}

class Header extends StatefulWidget {
  final ViewState viewState;
  final double smallFontSize;
  final double largeFontSize;
  final double smallIconSize;
  final double largeIconSize;

  const Header({
    Key key,
    this.viewState,
    this.smallFontSize = 20.0,
    this.largeFontSize = 32.0,
    this.smallIconSize = 24.0,
    this.largeIconSize = 0.0,
  }) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _fontSizeTween;
  Animation<double> _iconSizeTween;
  Animation<double> _paddingSizeTween;

  double fontSize;
  double iconSize;
  double paddingSize;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 330),
    )..addListener(() {
        setState(() {
          fontSize = _fontSizeTween.value;
          iconSize = _iconSizeTween.value;
          paddingSize = _paddingSizeTween.value;
        });
      });

    switch (widget.viewState) {
      case ViewState.enlarge:
        _fontSizeTween = Tween<double>(
          begin: widget.smallFontSize,
          end: widget.largeFontSize,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

        _iconSizeTween = Tween<double>(
          begin: widget.smallIconSize,
          end: widget.largeIconSize,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

        _paddingSizeTween = Tween<double>(
          begin: 8.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

        _animationController.forward(from: 0.0);
        break;

      case ViewState.enlarged:
        fontSize = widget.largeFontSize;
        iconSize = widget.largeIconSize;
        paddingSize = 0.0;
        break;

      case ViewState.shrink:
        _fontSizeTween = Tween<double>(
          begin: widget.largeFontSize,
          end: widget.smallFontSize,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

        _iconSizeTween = Tween<double>(
          begin: widget.largeIconSize,
          end: widget.smallIconSize,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

        _paddingSizeTween = Tween<double>(
          begin: 0.0,
          end: 4.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

        _animationController.forward(from: 0.0);
        break;

      case ViewState.shrunk:
        fontSize = widget.smallFontSize;
        iconSize = widget.smallIconSize;
        paddingSize = 4.0;
        break;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HeaderContent(
      iconSize: iconSize,
      fontSize: fontSize,
      textPadding: paddingSize,
    );
  }
}
