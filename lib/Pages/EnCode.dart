import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_demo/Public.dart';
import '../AES.dart';
import 'EnCodeQRs.dart';
import 'Scaffold_all.dart';

class EnCode extends StatelessWidget {
  final bool IsEnCode,IsQR;
  EnCode({this.IsEnCode = false,this.IsQR=false});

  @override
  Widget build(BuildContext context) {
    print(IsQR);
    return ScaffoldAll(
      title: IsEnCode&&IsQR?"AES QR kodda şifirle":IsEnCode?"AES Şifir":"QR kody döret",
      body: ListView(
        children: [
          Input(IsEnCode: IsEnCode,IsQR: IsQR,),
        ],
      ),
    );
  }
}

class Input extends StatefulWidget {
  final bool IsEnCode,IsQR;
  Input({this.IsEnCode,this.IsQR});
  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  TextEditingController txt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: TextFormField(
          onChanged: (input) {
            setState(() {
              ShifrVal="";ShifrKey="";EnCodeText=[];
              AESEnCode(txt.text);
            });
          },
          controller: txt,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: widget.IsEnCode
                ? "Sifirlenjek maglumaty giriz..."
                : "QR kodyň maglumatyny giriz...",
            prefixIcon: Icon(
              Icons.qr_code_sharp,
              color: Colors.purpleAccent,
            ),
            suffix: GestureDetector(
                onTap: () {
                  setState(() {
                    txt.clear();
                  });
                },
                child: Icon(
                  Icons.cancel_rounded,
                  color: Colors.white,
                )),
          ),
        ),
      ),
      widget.IsEnCode==widget.IsQR?MaterialButton(
        onPressed: () {
          widget.IsQR?Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => QREnCode(
                        IsEnCode: widget.IsEnCode,
                        value: txt.text,
                      )),
              (route) => false):
          setState((){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => QREnCode(
                      IsEnCode: widget.IsEnCode,
                      value: txt.text,
                    )),
                    (route) => false);
          })
          ;
        },
        child: Text(
          widget.IsEnCode ? "Şifrle" : "Döret",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.purple,
      ):Container(),
/*      MaterialButton(
        onPressed: () {
print(txt.text.codeUnitAt(0));
print("Ç".codeUnitAt(0));
print("ç".toUpperCase().codeUnitAt(0));
        },
        child: Text(
          "Gor",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blue,
      )*/
      AnimatedCrossFade(
    crossFadeState: !widget.IsEnCode||txt.text==""?CrossFadeState.showFirst:CrossFadeState.showSecond,
    duration: Duration(seconds: 1),
          firstChild: Container(),
          secondChild: Container(
            color:Colors.black,
            child:  Column(
              children: [
                MyText("Şifrlenen maglumat:", Colors.white, 0.05),
               // MyText(txt.text.toUpperCase(), Colors.white, 0.05),
                Column(
                  children: List.generate(
                      EnCodeText.length,
                          (index) => Container(
                        child: Column(
                          children: [
                            (index-(1+(txt.text.length-1)~/16)) % 9 == 0
                                ? MyText("${EnCodeText[index]}",
                                Colors.white, 0.04)
                                :((txt.text.length-1)~/16)>=index?
                            MyText("${EnCodeText[index]}",
                                Colors.blue, 0.06):MyText("${EnCodeText[index]}",
                                Colors.green[700], 0.03),
                          ],
                        ),
                      )),
                )
              ],
            ),
          ),
         )
    ]);
  }

  Padding MyText(String val, Color col, double size) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.03),
      child: Text(
        val,
        textAlign: TextAlign.center,
        style: TextStyle(color: col, fontSize: screenWidth * size),
      ),
    );
  }
}
