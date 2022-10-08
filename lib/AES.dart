import 'dart:math';

String ShifrVal="",ShifrKey="";
String Maglumat = "";
List AESs = [];
int a = 0,
    b = 0,
    c = 0,
    j = 0,
    k = 0,
    q = 0,
    w = 0,
    msh = 0,
    mixind = 0,
    raund = 0;
String s = "", sk = "";
List SRows, SubBytes, akey, ykey, skey, state, MixCol, smix, z;

void empetied() {
  SRows = List.generate(4, (i) => List<String>.generate(4, (index) => ""));
  SubBytes = List.generate(4, (i) => List<String>.generate(4, (index) => ""));
  akey = List.generate(4, (i) => List<String>.generate(4, (index) => ""));
  ykey = List.generate(4, (i) => List<String>.generate(4, (index) => ""));
  skey = List.generate(4, (i) => List<String>.generate(4, (index) => ""));
  state = List.generate(4, (i) => List<String>.generate(4, (index) => ""));
  MixCol = List.generate(4, (i) => List<String>.generate(4, (index) => ""));
  smix = List.generate(4, (i) => List.generate(4, (index) => 0));
  z = List.generate(16, (index) => "");
}


List    DeCodeText=[],EnCodeText=[],
    letters = [
  "", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
  "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
  " ", //27
  "Ä",
  "Ö",
  "Ş",
  "Ň",
  "Ý",
  "Ž",
  "Ü",
  "Ç", //28..35
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9" //36..45
],
    Rcon = ["01", "02", "04", "08", "10", "20", "40", "80", "1B", "36"],
    S_box = [
      ["63	7C	77	7B	F2	6B	6F	C5	30	01	67	2B	FE	D7	AB	76"],
      ["CA 	82 	C9 	7D 	FA 	59 	47 	F0 	AD 	D4 	A2 	AF 	9C 	A4 	72 	C0"],
      ["B7 	FD 	93 	26 	36 	3F 	F7 	CC 	34 	A5 	E5 	F1 	71 	D8 	31 	15"],
      ["04 	C7 	23 	C3 	18 	96 	05 	9A 	07 	12 	80 	E2 	EB 	27 	B2 	75"],
      ["09 	83 	2C 	1A 	1B 	6E 	5A 	A0 	52 	3B 	D6 	B3 	29 	E3 	2F 	84"],
      ["53	D1	00	ED	20	FC	B1	5B	6A	CB	BE	39	4A	4C	58	CF"],
      ["D0	EF	AA	FB	43	4D	33	85	45	F9	02	7F	50	3C	9F	A8"],
      ["51 	A3 	40 	8F 	92 	9D 	38 	F5 	BC 	B6 	DA 	21 	10 	FF 	F3 	D2"],
      ["CD 	0C 	13 	EC 	5F 	97 	44 	17 	C4 	A7 	7E 	3D 	64 	5D 	19 	73"],
      ["60 	81 	4F 	DC 	22 	2A 	90 	88 	46 	EE 	B8 	14 	DE 	5E 	0B 	DB"],
      ["E0 	32 	3A	0A 	49 	06 	24 	5C 	C2 	D3 	AC 	62 	91 	95	E4 	79"],
      ["E7 	C8 	37 	6D 	8D 	D5 	4E 	A9 	6C 	56 	F4 	EA 	65 	7A 	AE 	08"],
      ["BA 	78 	25 	2E 	1C 	A6 	B4 	C6 	E8 	DD 	74 	1F 	4B 	BD 	8B 	8A"],
      ["70 	3E 	B5 	66 	48 	03 	F6 	0E 	61 	35 	57 	B9 	86 	C1 	1D 	9E"],
      ["E1 	F8 	98 	11 	69 	D9 	8E 	94 	9B 	1E 	87 	E9 	CE 	55 	28 	DF"],
      ["8C 	A1 	89 	0D 	BF 	E6 	42 	68 	41 	99 	2D 	0F 	B0 	54 	BB 	16"]
    ],
    InvS_box = [
      ["52 	09 	6A 	D5 	30 	36 	A5 	38 	BF 	40 	A3 	9E 	81 	F3 	D7 	FB"],
      ["7C 	E3 	39 	82 	9B 	2F 	FF 	87 	34 	8E 	43 	44 	C4 	DE 	E9 	CB"],
      ["54	7B 	94 	32 	A6 	C2 	23 	3D 	EE 	4C 	95 	0B 	42 	FA 	C3 	4E"],
      ["08 	2E 	A1 	66 	28 	D9 	24 	B2 	76 	5B 	A2 	49 	6D 	8B 	D1 	25"],
      ["72 	F8 	F6 	64 	86 	68 	98 	16 	D4 	A4 	5C 	CC 	5D 	65 	B6 	92"],
      ["6C 	70 	48 	50 	FD 	ED 	B9 	DA 	5E 	15 	46 	57 	A7 	8D 	9D 	84"],
      ["90 	D8 	AB 	00 	8C 	BC 	D3 	0A 	F7 	E4 	58 	05 	B8 	B3 	45 	06"],
      ["D0 	2C 	1E 	8F 	CA 	3F 	0F 	02 	C1 	AF 	BD 	03 	01 	13 	8A 	6B"],
      ["3A 	91 	11 	41 	4F 	67 	DC 	EA 	97 	F2 	CF 	CE 	F0 	B4 	E6 	73"],
      ["96 	AC 	74 	22 	E7 	AD 	35 	85 	E2 	F9 	37 	E8 	1C 	75 	DF 	6E"],
      ["47 	F1 	1A 	71 	1D 	29 	C5 	89 	6F 	B7 	62 	0E 	AA 	18 	BE 	1B"],
      ["FC 	56 	3E 	4B 	C6 	D2 	79 	20 	9A 	DB 	C0 	FE 	78 	CD 	5A 	F4"],
      ["1F 	DD 	A8 	33 	88 	07 	C7 	31 	B1 	12 	10 	59 	27 	80 	EC 	5F"],
      ["60 	51 	7F 	A9 	19 	B5 	4A 	0D 	2D 	E5 	7A 	9F 	93 	C9 	9C 	EF"],
      ["A0 	E0 	3B 	4D 	AE 	2A 	F5 	B0 	C8 	EB 	BB 	3C 	83 	53 	99 	61"],
      ["17 	2B 	04 	7E 	BA 	77 	D6 	26 	E1 	69 	14 	63 	55 	21 	0C 	7D"],
    ];

/*<SISTEMALAR================================================================>*/
/*inthex=======================*/
int inthex(o) {
  List<String> hex16 = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F"
  ];
  return hex16.indexOf(o);
}

/*10dan 16-lyk sistema gecyar============*/
String hex(int o) {
  String sh = "";
  int b;
  if (o == 0) sh = "0";
  while (o > 0) {
    b = o % 16;
    o = o ~/ 16;
    if (b >= 0 && b <= 9) {
      sh = String.fromCharCode(b + 48) + sh;
    } else {
      sh = String.fromCharCode(b + 55) + sh;
    }
  }
  return sh;
}

/*10dan 2-lik sistemadaky uzynlygy============*/
int binsize(int smc) {
  int bi=0, smb=0;
  while (smc > 0) {
    smb = smc % 2;
    smc = smc ~/ 2;
    bi += 1;
  }
  bi -= 1;
  return bi;
}

/*16dan 10-lyk sistema gecyar============*/
int dec(String o) {
  int i, de = 0, power = 0;
  for (i = o.length - 1; i >= 0; i--) {
    de += (inthex(o[i])) * (pow(16, power));
    power += 1;
  }
  return de;
}
/*<=========================================================================>*/
/*S-box============================*/
String sbox(String sh) {
  int fo, fo2, i = 0, l = 0, se, su, e, d = 0;
  String t,  result = "", chr9 = String.fromCharCode(9);
  if (sh.length == 1) {
    se = 0;
    su = inthex(sh[0]);
  } else {
    se = inthex(sh[0]);
    su = inthex(sh[1]);
  }
  for (int j = 0; j < S_box.length; j++) {
    t = S_box[j].toString().substring(1, S_box[j].toString().length - 1);
    e = 0;
    t += chr9;
    if (i == se)
      for (fo = 0; fo < t.length; fo++)
        if (t[fo] == chr9) {
          d = fo;
          for (fo2 = e; fo2 <= d; fo2++)
            if (l == su && t[fo2] != chr9 && t[fo2] != " ") result += t[fo2];
          e = d;
          l += 1;
        }
    i += 1;
  }
  return result;
}
/*InvS-box============================*/
String invsbox(String sh) {
  int fo, fo2, i = 0, l = 0, se, su, e, d = 0;
  String t,  result = "", chr9 = String.fromCharCode(9);
  if (sh.length == 1) {
    se = 0;
    su = inthex(sh[0]);
  } else {
    se = inthex(sh[0]);
    su = inthex(sh[1]);
  }
  for (int j = 0; j < S_box.length; j++) {
    t = InvS_box[j].toString().substring(1, InvS_box[j].toString().length - 1);
    e = 0;
    t += chr9;
    if (i == se)
      for (fo = 0; fo < t.length; fo++)
        if (t[fo] == chr9) {
          d = fo;
          for (fo2 = e; fo2 <= d; fo2++)
            if (l == su && t[fo2] != chr9 && t[fo2] != " ") result += t[fo2];
          e = d;
          l += 1;
        }
    i += 1;
  }
  return result;
}


/*ShiftRows============================*/
void ShiftRows() {
  int fo, fo2, i;
  for (fo = 0; fo < 4; fo++)
    for (fo2 = 0; fo2 < 4; fo2++) {
      i = fo2 + fo;
      if (i > 3) i -= 4;
      SRows[fo][fo2] = SubBytes[fo][i];
      if (fo == fo2)
        smix[fo][fo2] = 2;
      else if (fo == fo2 - 1 || fo == 3 && fo2 == 0)
        smix[fo][fo2] = 3;
      else
        smix[fo][fo2] = 1;
    }
}

/*MixColumns ============================*/
String MixColumns(String sh, int sm) {
  int ko = 0;
  msh += 1;
  if (sm == 2)
    ko = dec(sh) * 2;
  else if (sm == 3)
    ko = (dec(sh) * 2) ^ dec(sh);
  else
    ko = dec(sh);
  if (ko > 255) ko = ko ^ 283;
  if (msh == 1)
    w = ko;
  else if (msh > 1) w = w ^ ko;
  if (msh == 4) {
    msh = 0;
    z[mixind] = hex(w);
    mixind += 1;
    w = 0; //writeln;
  }
}

/*KeyExpansion ============================*/
void KeyExpansion() {
  int fo, fo2, e = 0;
  String t;
  for (fo = 0; fo < 4; fo++)
    for (fo2 = 0; fo2 < 4; fo2++) {
      if (fo == 0) {
        if (fo2 == 3)
          akey[0][3] = sbox(ykey[3][0]);
        else
          akey[0][fo2] = sbox(ykey[3][fo2 + 1]);

        //assign(f,'AES/tablisa/Rcon.txt');reset(f);
        //Rcon
        for (int j = 0; j < Rcon.length; j++) {
          t = Rcon[j];
          e += 1;
          if (e == raund) akey[0][0] = hex(dec(akey[0][0]) ^ dec(t));
        }
        akey[0][fo2] = hex(dec(akey[0][fo2]) ^ dec(ykey[0][fo2]));
      } else
        akey[fo][fo2] = hex(dec(akey[fo - 1][fo2]) ^ dec(ykey[fo][fo2]));
      if (akey[fo][fo2].length == 1) akey[fo][fo2] = '0' + akey[fo][fo2];
    }
}
/*InvShiftRows============================*/
void InvShiftRows() {
  int fo, fo2, i;
  for (fo = 0; fo < 4; fo++)
    for (fo2 = 0; fo2 < 4; fo2++) {
      i = fo2 - fo;
      if (i < 0) i += 4;
      SRows[fo][fo2] = state[i][fo];
      if (fo == fo2)
        smix[fo][fo2] = 14;
      else if (fo == fo2 - 1 || (fo == 3 && fo2 == 0))
        smix[fo][fo2] = 11;
      else if (fo == fo2 + 1 || (fo == 0 && fo2 == 3))
        smix[fo][fo2] = 9;
      else
        smix[fo][fo2] = 13;
    }
}

/*InvKeyExpansion ============================*/
void InvKeyExpansion() {
  int fo, fo2, e = 0;
  String t;
  for (fo = 3; fo >= 0; fo--)
    for (fo2 = 0; fo2 < 4; fo2++) {
      if (fo == 0) {
//Sub Rot-----------
        if (fo2 == 3)
          akey[0][3] = sbox(akey[3][0]);
        else
          akey[0][fo2] = sbox(akey[3][fo2 + 1]);
//------------------
        for (int j = 0; j < Rcon.length; j++) {
          t = Rcon[j];
          e += 1;
          if (e == raund) akey[0][0] = hex(dec(akey[0][0]) ^ dec(t));
        }
        akey[0][fo2] = hex(dec(akey[0][fo2]) ^ dec(ykey[0][fo2]));
      } else
        akey[fo][fo2] = hex(dec(ykey[fo - 1][fo2]) ^ dec(ykey[fo][fo2]));
      if (akey[fo][fo2].length == 1) akey[fo][fo2] = '0' + akey[fo][fo2];
    }
}

/*InvMixColumns=========================*/
String InvMixColumns(String sh, int sm) {
  int ko = 0, smc = 0, smb = 0, bi = 0;
  smc = sm;
  while (smc > 0) {
    smb = smc % 2;
    smc = smc ~/ 2;
    ko = ko ^ (dec(sh) * (pow(2, bi)) * smb); //writeln(smb,'  ',ko);
    bi++;
  }
  bi = 0;
  while (binsize(ko) > 7) {
    ko = ko ^ ((pow(2, binsize(ko) - 8)) * 283);
  }
  msh += 1;
  if (msh == 1)
    w = ko;
  else if (msh > 1) w = w ^ ko;
  if (msh == 4) {
    msh = 0;
    z[mixind] = hex(w);

    mixind += 1;
    w = 0;
  }
}

String AESFill(val) {
  if (val.length < 16) for (int i = val.length; i < 16; i++) val += " ";
  return val;
}

void AESEnCode(String val) {
  empetied();
  AESs = [];
  String sh = "", s1 = "";
  s1 = val.toUpperCase();
  s1 = AESFill(s1);

  if (s1.length > 16) {
    while (s1.length > 0) {
      s1 = AESFill(s1);
      AESs.add(s1.substring(0, 16));
      EnCodeText.add("${s1.substring(0, 16)}");
      s1 = s1.substring(16);
    }
  } else if (s1.length == 16) {
    AESs.add(s1);
    EnCodeText.add(s1);
  }

  for(int aesfor=0;aesfor<AESs.length;aesfor++) {
    for (k = 0; k < 4; k++)
      for (j = 0; j < 4; j++) {
        skey[k][j] = hex(letters.indexOf(AESs[aesfor][a]));
        ykey[k][j] = hex(a);
        a += 1;
      }

    /*==================================================================*/
    for (raund = 1; raund <= 10; raund++) {
      for (k = 0; k < 4; k++)
        for (j = 0; j < 4; j++) {
          a = 0;
          state[k][j] = hex(dec(skey[k][j]) ^ dec(ykey[k][j]));
          SubBytes[j][k] = sbox(state[k][j]);
        }
      // print('***ItisWork');

      ShiftRows();
      mixind = 0;
      if (raund < 10) {
        for (k = 0; k < 4; k++)
          for (j = 0; j < 4; j++)
            for (q = 0; q < 4; q++)
              MixColumns(SRows[q][k], smix[j][q]);
        for (k = 0; k < 4; k++)
          for (j = 0; j < 4; j++) {
            MixCol[k][j] = z[a];
            a += 1;
          }
        a = 0;
      }
      KeyExpansion();
      /*===============================*/
      EnCodeText.add('Sifr Raund $raund');
      //print('{==========================================================}');
      EnCodeText.add('${skey.toString()}  //maglumat');
      EnCodeText.add('${ykey.toString()}  //acar');
      //print('----------------------');
      EnCodeText.add("${state.toString()}");
      EnCodeText.add("${SubBytes.toString()}");
      EnCodeText.add("${SRows.toString()}");
      if (raund < 10) {
        EnCodeText.add("${smix.toString()}");
        //print('----------------------------------------------------------');
        EnCodeText.add('${MixCol.toString()}  //Maglumat');
      }
      //print('----------------------------------------------------------');
      EnCodeText.add('${akey.toString()}  //Acar');

      if (raund < 10)
      //  print('{==========================================================}');
      /*===============================*/
      for (k = 0; k < 4; k++)
        for (j = 0; j < 4; j++) {
          skey[k][j] = MixCol[k][j];
          ykey[k][j] = akey[k][j];
        }
      /*===============================*/

    }
    for (k = 0; k < 4; k++)
      for (j = 0; j < 4; j++) {
        a = 0;
        state[k][j] = hex(dec(SRows[j][k]) ^ dec(akey[k][j]));
        if (state[k][j].length == 1) state[k][j] = "0" + state[k][j];
      }
    ShifrVal += state.toString().replaceAll("[", "").replaceAll("]", "")
        .replaceAll(",", "").replaceAll(" ", "");
    ShifrKey += akey.toString().replaceAll("[", "").replaceAll("]", "")
        .replaceAll(",", "").replaceAll(" ", "");
    EnCodeText.add('${ShifrKey}  //Acar');
    EnCodeText.add('${ShifrVal}  //Maglumat');

    //print('{==========================================================}');

    /*==================================================================*/
  }
}

void AESDeshifr(String Val, Ke) {
  empetied();Maglumat="";
/* desifr=========================================================*/
  for (int aesfor = 0; aesfor < Val.length ~/ 32; aesfor++) {
    a = 0;
    empetied();
    s = Val.substring(32 * aesfor, 32 * (aesfor + 1));
    sk = Ke.substring(32 * aesfor, 32 * (aesfor + 1));

    print("${s} $sk");
    for (k = 0; k < 4; k++)
      for (j = 0; j < 4; j++)
        for (int i = 0; i < 2; i++) {
          state[k][j] += s[a];
          ykey[k][j] += sk[a];
          a++;
        }

    print(state);
    print(akey);
    for (k = 0; k < 4; k++)
      for (j = 0; j < 4; j++)
        state[k][j] = hex(dec(state[k][j]) ^ dec(ykey[k][j]));

    for (raund = 10; raund > 0; raund--) {
      DeCodeText.add('Desifr Raund $raund');
      // DeCodeText.add('{==========================================================}');
      InvShiftRows();
      for (k = 0; k < 4; k++)
        for (j = 0; j < 4; j++) SubBytes[j][k] = invsbox(SRows[k][j]);

      InvKeyExpansion();

      for (k = 0; k < 4; k++)
        for (j = 0; j < 4; j++)
          state[k][j] = hex(dec(SubBytes[k][j]) ^ dec(akey[k][j]));
      a = 0;
      mixind = 0;

      for (k = 0; k < 4; k++)
        for (j = 0; j < 4; j++)
          for (q = 0; q < 4; q++) InvMixColumns(state[k][q], smix[j][q]);

      for (k = 0; k < 4; k++)
        for (j = 0; j < 4; j++) {
          MixCol[k][j] = z[a];
          a++;
        }
      //print("***ItsWork 3");
      DeCodeText.add("${SRows.toString()}");
      DeCodeText.add("${SubBytes.toString()}");
      DeCodeText.add("${akey.toString()}  //Acar");
      if (raund == 1) {
        DeCodeText.add("${state.toString()}  //Maglumat");
        s = '';
        for (k = 0; k < 4; k++)
          for (j = 0; j < 4; j++) {
            //s += String.fromCharCode(dec(state[k][j]) + 64);
            s += letters[dec(state[k][j])];
          }
        Maglumat += s;
        DeCodeText.add(s);
      } else {
        DeCodeText.add("${state.toString()}");
        DeCodeText.add("${MixCol.toString()}  //Maglumat");
      }
      // DeCodeText.add('{==========================================================}');
      /*===============================*/
      for (k = 0; k < 4; k++)
        for (j = 0; j < 4; j++) {
          state[k][j] = MixCol[k][j];
          ykey[k][j] = akey[k][j];
        }
      /*===============================*/
    }
  }
}
