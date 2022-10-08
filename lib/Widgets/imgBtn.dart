import 'package:flutter/material.dart';

class ImgBtn extends StatelessWidget {
  final double width, height,shape,radius;
  final Color color;
  final onTap;
  final Widget child;
  final bool ISsCircle;
  final List<Color> colors;
  final  boxShadow;
  ImgBtn(
      {this.width=100,
      this.height=100,
        this.radius,
      this.color = Colors.black,
      this.colors,
      this.onTap,
      this.child,
      this.shape=0,
      this.ISsCircle=false,
      this.boxShadow});

  @override
  Widget build(BuildContext context) {
   if( ISsCircle){
     return GestureDetector(
       onTap: onTap,
       child: Container(
         height: radius,
         width: radius,
         decoration: BoxDecoration(
           gradient: LinearGradient(
             begin: Alignment.topLeft,
             end: Alignment.bottomRight,
             colors:colors==null?[color,color]:colors,
           ),
         shape:BoxShape.circle,
           boxShadow: boxShadow
         ),
        // width: width,
         //height: height,
        // child: Center(child: child),
         child: child,
       ),
     );
   }
   else
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadiusDirectional.circular(shape),
                  color: color,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors==null?[color,color]:colors,
          ),
           boxShadow: boxShadow
               ),
        width: width,
        height: height,
        child: Center(child: child),
      ),
    );
  }
}
