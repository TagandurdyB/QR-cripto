import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_demo/Pages/AbautPage.dart';
import 'package:qr_demo/Pages/DeCodePage.dart';
import 'package:qr_demo/Pages/MainPage.dart';
import 'package:qr_demo/Pages/ScanPage.dart';
import 'package:qr_demo/Public.dart';
import 'package:qr_demo/Widgets/DrawBarBtn.dart';
import 'package:qr_demo/Widgets/imgBtn.dart';

import 'EnCode.dart';

class ScaffoldAll extends StatelessWidget {
  final Widget body, faltActionBtn;
  final String title;
  ScaffoldAll({Key key, this.body, this.faltActionBtn,this.title="MGIT"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.purple,
        title: Text(title),
        centerTitle: true,
      ),
      floatingActionButton: faltActionBtn,
      endDrawer: EndDraver(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: body,
        color: Colors.grey[800],
      ),
    );
  }
}

void RSAKeys(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text("Mgit RSA "),
          ),
          content: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "",
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ýatyr")),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Üýtget")),
          ],
        );
      });
}

class EndDraver extends StatelessWidget {
  const EndDraver({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> Col = [  Colors.purple[900],Colors.pink[900],Colors.orange[600]];
    return Drawer(
      child: Container(
        color: Colors.purple,
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(30),
        child: SafeArea(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              DrawBarBtn(
                colors: Col,
                title: Text("Baş sahypa"),
                trailing: Icon(Icons.home),
                leading: Container(),
                onTap: (context) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                      (route) => false);
                },
              ),
              DrawBarBtn(
                colors: Col,
                title: Text("Biz barada"),
                trailing: Icon(Icons.account_box),
                leading: Container(),
                onTap: (context) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => AbautPage()),
                          (route) => false);
                },
              ),
              DrawBarSeperator("QR"),
              DrawBarBtn(
                colors: Col,
                title: Text("QR kody okat"),
                trailing: Icon(Icons.qr_code_scanner),
                leading: Container(),
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
                trailing: Icon(Icons.qr_code_2_rounded),
                leading: Container(),
                onTap: (context) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => EnCode()),
                      (route) => false);
                },
              ),
              DrawBarSeperator("AES"),
              DrawBarBtn(
                colors: Col,
                title: Text("Şifirle"),
                trailing: Icon(Icons.lock),
                leading: Text("AES"),
                onTap: (context) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EnCode(IsEnCode: true)),
                          (route) => false);
                },
              ),
              DrawBarBtn(
                colors: Col,
                title: Text("Deşifrle"),
                trailing: Icon(Icons.lock_open_outlined),
                leading: Text("AES"),
                onTap: (context) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DeCodePage()),
                          (route) => false);
                },
              ),
              DrawBarBtn(
                colors: Col,
                title: Text("QR kodda deşifrle"),
                trailing: Icon(Icons.qr_code_scanner),
                leading: Text("AES"),
                onTap: (context) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScanPage(IsDeCode: true)),
                      (route) => false);
                },
              ),
              DrawBarBtn(
                colors: Col,
                title: Text("QR kodda şifirle"),
                trailing: Icon(Icons.qr_code_sharp),
                leading: Text("AES"),
                onTap: (context) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EnCode(IsEnCode: true,IsQR: true)),
                      (route) => false);
                },
              ),
              DrawBarSeperator("RSA"),
              DrawBarBtn(
                colors: Col,
                title: Text("Açarlar"),
                leading: Icon(Icons.vpn_key_outlined,color: Colors.white,),
                trailing: Icon(Icons.vpn_key),
                onTap: (context) {
                  RSAKeys(context);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  Padding DrawBarSeperator(String txt) {
    return Padding(
              padding:  EdgeInsets.all(screenWidth*0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(txt,textAlign: TextAlign.left,),
                  Expanded(child: Container(
                    margin: EdgeInsets.only(left: screenWidth*0.01),
                    height: 1,width:double.infinity,color: Colors.white,)),
                ],
              ),
            );
  }
}
