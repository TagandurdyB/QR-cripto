import 'dart:io';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:qr_demo/Pages/Scaffold_all.dart';
import 'package:qr_demo/Public.dart';

import 'ResultPage.dart';

class ScanPage extends StatefulWidget {
  final bool IsDeCode;
  ScanPage({this.IsDeCode=false});
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final qrKey = GlobalKey(debugLabel: "QR");
  QRViewController control;
  Barcode barcode,value;
  int num=0;
  String QRtext="";

  @override
  void dispode() {
    control.dispose();
    super.dispose();
  }

  @override
  void reasemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await control.pauseCamera();
    }
    control.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldAll(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQRViev(context),
          Positioned(
              bottom: 40,
              child: Text(
                barcode==null?
                "Maglumaty okadyň":
                widget.IsDeCode?"Açary okadyň":QRtext,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple),
              ))
        ],
      ),
    );
  }

  Widget buildQRViev(context) => QRView(
        key: qrKey,
        onQRViewCreated: (controller) {
          setState(() => this.control = controller);
          control.scannedDataStream.listen((event) {
            widget.IsDeCode?
            setState(() {
              barcode = event;
              String val="";
              value==null?val="":val=value.code;
              if("${barcode.code}"!="${val}")
                num++;
              if(num==1)
                value=barcode;
             print("num*** $num");
             if(num==2)
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Resultpage(Value: value.code, Key: barcode.code)));
            }):setState((){
              barcode = event;
              QRtext=barcode.code;
            });

          });
        },
        overlay: QrScannerOverlayShape(
            borderWidth: 10,
            borderRadius: 10,
            borderLength: 20,
            borderColor: Colors.deepPurpleAccent,
            cutOutSize: screenWidth * 0.8),
      );
}

