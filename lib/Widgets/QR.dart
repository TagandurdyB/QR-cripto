import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../Public.dart';
import 'imgBtn.dart';

class QR_Generate extends StatefulWidget {
  final double size;
  final String data;
QR_Generate({this.size=200,this.data="Tagandurdy.B.M"});
  @override
  State<QR_Generate> createState() => _QR_GenerateState();
}

class _QR_GenerateState extends State<QR_Generate> {
  @override
  final cotroller=TextEditingController();

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(screenWidth*0.04),
      child: ImgBtn(
        width: widget.size,
        height: widget.size,
        /*decoration: BoxDecoration(
          shape: BoxShape.rectangle,
            color: Colors.orange,
          borderRadius: BorderRadiusDirectional.circular(16)
        ),*/
        colors: [Colors.purple,Colors.orange],
          shape: screenWidth*0.06,
          child: Padding(
padding: EdgeInsets.all(10),
child:QrImage(
            embeddedImage: Image.asset("assets/logo.png").image,
            data:widget.data,
           //     backgroundColor: Colors.white,
           // size: 100,
          ),
),
      ),
    );
  }
}

class QR_Scaner extends StatefulWidget {
  @override
  State<QR_Scaner> createState() => _QR_ScanerState();
}

class _QR_ScanerState extends State<QR_Scaner> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

