import 'package:flutter/material.dart';

import '../Public.dart';
class DrawBarBtn extends StatelessWidget {
  Widget leading, title, trailing;
  double width;
  Color color;
  List<Color> colors;
  Function onTap;
  DrawBarBtn({this.leading, this.title, this.trailing, this.onTap,this.color=Colors.transparent,this.width=double.infinity,this.colors});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: () {
          onTap(context);
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadiusDirectional.circular(screenWidth*0.03),
            gradient: LinearGradient(
              colors: colors==null?[color,color]:colors,
              begin: Alignment.topLeft,
              end:Alignment.bottomRight
            )
          ),
          width: width,
          padding: EdgeInsets.all(8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(height: screenWidth*0.15,),
              Positioned(child: leading, left: 2),
              Positioned(child: title),
              Positioned(child: trailing, right: 2),
            ],
          ),
        ),
      ),
    );
  }
}