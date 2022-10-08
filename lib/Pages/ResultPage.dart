import 'package:flutter/material.dart';
import '../Pages/Scaffold_all.dart';
import '../Public.dart';
import '../Widgets/QR.dart';
import '../AES.dart';

class Resultpage extends StatelessWidget {
  final String Value, Key;
  Resultpage({@required this.Value, @required this.Key});
  @override
  Widget build(BuildContext context) {
    DeCodeText = [];
    AESDeshifr(Value, Key);
    return RezultView(
      Value: Value,
      Key: Key,
    );
  }
}

class RezultView extends StatefulWidget {
  final String Value, Key;
  RezultView({@required this.Value, @required this.Key});
  @override
  State<RezultView> createState() => _RezultViewState();
}

class _RezultViewState extends State<RezultView> {
  bool IsCodeOpen = false;
  @override
  Widget build(BuildContext context) {
    return ScaffoldAll(
      faltActionBtn: FloatingActionButton(
        onPressed: () {
          setState(() {
            IsCodeOpen = !IsCodeOpen;
          });
        },
        child: Icon(Icons.code),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              QR_Generate(
                data: widget.Value,
              ),
              MyText("Maglumat:", Colors.white, 0.05),
              MyText("${widget.Value}", Colors.purpleAccent, 0.04),
              Divider(
                color: Colors.purpleAccent,
              ),
              QR_Generate(
                data: widget.Key,
              ),
              MyText("Açar:", Colors.white, 0.05),
              MyText("${widget.Key}", Colors.purpleAccent, 0.04),
              Divider(
                color: Colors.purpleAccent,
              ),
            ],
          ),
          Container(
            child: Column(
              children: [
                MyText("Deşifrlenen maglumat:", Colors.white, 0.05),
                MyText("$Maglumat", Colors.blue, 0.04),
              ],
            ),
          ),

               AnimatedCrossFade(
crossFadeState: IsCodeOpen?CrossFadeState.showFirst:CrossFadeState.showSecond,
                 duration: Duration(seconds: 1),
                  firstChild:Container(
                    color:Colors.black,
                    child: Column(
                      children: [
                        MyText("Giňişleýin Deşifrlenen maglumat:", Colors.white,
                            0.05),
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
                                                Colors.grey, 0.03),
                                      ],
                                    ),
                                  )),
                        )
                      ],
                    ),
                  ),
                 secondChild: Container(),
                )
        ],
      ),
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
}


