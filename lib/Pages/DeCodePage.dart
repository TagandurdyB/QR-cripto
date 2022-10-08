import 'package:flutter/material.dart';
import '../AES.dart';
import '../Public.dart';
import 'Scaffold_all.dart';



class DeCodePage extends StatelessWidget {
  // const DeCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldAll(
      title: "AES Deşifirle",
      body: ListView(
        children: [
          InputGrup()
        ],
      ),
    );
  }
}

class InputGrup extends StatefulWidget {

  @override
  _InputGrupState createState() => _InputGrupState();
}

class _InputGrupState extends State<InputGrup> {
  List txts=[
    TextEditingController(),
    TextEditingController(),
  ];
  String Val="",Key="";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyInput(0,"Habary giriz...",Icons.message),
        MyInput(1,"Açary giriz...",Icons.vpn_key),
        DecodeBtn(),
        if(Val!=""&&Key!="")Container(
          color:Colors.black,
          child: Column(
            children: [
              MyText("Giňişleýin Deşifrlenen maglumat:", Colors.white,
                  0.05),
              MyText("${DeCodeText[DeCodeText.length-1]}", Colors.blue,
                  0.04),
              Column(
                children: List.generate(
                    DeCodeText.length,
                        (index) => Container(
                      child: Column(
                        children: [
                          index % 6 == 0
                              ? MyText("${DeCodeText[index]}",
                              Colors.white, 0.04)
                              : MyText("${DeCodeText[index]}",
                              Colors.green[700], 0.03),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ],
    );
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

  Widget MyInput(int index,String hintText,IconData icon){
    return  Container(
      padding: EdgeInsets.all(screenWidth * 0.02),
      child: TextFormField(
        controller: txts[index],
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
           icon,
            color: Colors.purpleAccent,
          ),
          suffix: GestureDetector(
              onTap: () {
                setState(() {
                  txts[index].clear();
                });
              },
              child: Icon(
                Icons.cancel_rounded,
                color: Colors.white,
              )),
        ),
      ),
    );
  }

  MaterialButton DecodeBtn() {
    return MaterialButton(
        color: Colors.purple,
        onPressed: () {
          setState(() {
            Val=txts[0].text;
            Key=txts[1].text;
            DeCodeText = [];
            AESDeshifr(Val, Key);
          });
        },
        child: Text(
          "Deşifrle",
          style: TextStyle(color: Colors.white),
        ));
  }

}


