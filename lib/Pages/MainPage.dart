import 'package:flutter/material.dart';
import 'package:qr_demo/Widgets/DrawBarBtn.dart';
import '../Public.dart';
import '../Widgets/QR.dart';
import 'EnCode.dart';
import 'Scaffold_all.dart';
import 'ScanPage.dart';

class MainPage extends StatelessWidget {
   List<Color>Col=[Colors.yellow[800],Colors.orange[900],Colors.purple];
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return ScaffoldAll(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          QR_Generate(
            size: screenWidth * 0.5,
            data: '''
Bu prlaženiýa Türkmenistanyň Telekommunikasiýalar 
we Informatika institudynyň MGIT kafedrasynyň talyby
Tagandurdy Baýramdurdyýew Mekanowiç 
tarapyndan 2022-nji ýylda ýasalandyr
            ''',
          ),
         Padding(
           padding:  EdgeInsets.all(screenWidth*0.1),
           child: Column(
             children: [
               DrawBarBtn(
                 colors: Col,
                 title: Text("QR kody okat"),
                 leading: Icon(Icons.qr_code_scanner_sharp),
                 trailing: Container(),
                 onTap: (context) {
                   Navigator.pushAndRemoveUntil(
                       context,
                       MaterialPageRoute(builder: (context) => ScanPage()),
                           (route) => false);
                 },
               ),
               DrawBarBtn(
                 colors: Col,
                 title: Text("QR kody döret"),
                 leading: Icon(Icons.qr_code_2_rounded),
                 trailing: Container(),
                 onTap: (context) {
                   Navigator.pushAndRemoveUntil(
                       context,
                       MaterialPageRoute(builder: (context) => EnCode()),
                           (route) => false);
                 },
               ),
             /*  DrawBarBtn(
                 colors: Col,
                 title: Text("Okat we deşifrle"),
                 leading: Icon(Icons.qr_code_scanner),
                 trailing: Container(),
                 onTap: (context) {
                   Navigator.pushAndRemoveUntil(
                       context,
                       MaterialPageRoute(builder: (context) => ScanPage(IsDeCode: true)),
                           (route) => false);
                 },
               ),
               DrawBarBtn(
                 colors: Col,
                 title: Text("Şifirle"),
                   leading: Icon(Icons.qr_code_sharp),
                 trailing: Container(),
                 onTap: (context) {
                   Navigator.pushAndRemoveUntil(
                       context,
                       MaterialPageRoute(builder: (context) => EnCode(IsEnCode: true)),
                           (route) => false);
                 },
               ),*/
           ],),
         )

          /* Text("${15 ^ 4}"),*/
        ],
      ),
    );
  }
}
