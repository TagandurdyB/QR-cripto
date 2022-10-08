import 'package:flutter/material.dart';
import './Scaffold_all.dart';
import '../Public.dart';
import '../Widgets/QR.dart';
import '../AES.dart';



class QREnCode extends StatelessWidget {
  final bool IsEnCode;
  final String value;
  QREnCode({@required this.value,this.IsEnCode=false});
  @override
  Widget build(BuildContext context) {
    ShifrVal="";ShifrKey="";
    if(IsEnCode) AESEnCode(value);
    return ScaffoldAll(
      body: PageView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             /* Padding(
                padding:  EdgeInsets.only(left: screenWidth*0.05,right: screenWidth*0.05),
                child: Text(IsEnCode?"${ShifrVal}":"",textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white)),
              ),*/
               /*Text("${value}",
                  style: TextStyle(color: Colors.white)),*/
              QR_Generate(
                data: IsEnCode?ShifrVal:value,
                size: screenWidth * 0.7,
              ),
              Text(
                IsEnCode?"MAGLUMAT":"$value",
                style: TextStyle(
                    color: Colors.white, fontSize: screenWidth * 0.06),
              ),
            ],
          ),
         if(IsEnCode) Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             /* Padding(
                padding:  EdgeInsets.only(left: screenWidth*0.05,right: screenWidth*0.05),
                child: Text("${ShifrKey}",textAlign: TextAlign.center,style: TextStyle(color: Colors.white)),
              ),*/
              QR_Generate(
                data: ShifrKey,
                size: screenWidth * 0.7,
              ),
              Text(
                "AÇAR",
                style: TextStyle(
                    color: Colors.white, fontSize: screenWidth * 0.06),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

