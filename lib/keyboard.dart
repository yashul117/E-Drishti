import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;
  //Button Widget
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          calculation(btntxt);
        },
        child: Text(
          '$btntxt',
          style: TextStyle(
            fontSize: 35,
            color: txtcolor,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: btncolor,
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
      ),
    );
  }

  var check;

  @override
  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Braille'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            print('start');
            if (finalResult != null && finalResult.length > 0) {
              text = text.substring(0, text.length - 1);
              finalResult = finalResult.substring(0, finalResult.length - 1);

              setState(
                () {
                  text = finalResult;
                },
              );
            }
          },
          onVerticalDragEnd: (DragEndDetails details) {
            print('start');
            if (finalResult != null && finalResult.length > 0) {
              text = text + ' ';
              finalResult = finalResult + ' ';

              setState(
                () {
                  text = finalResult;
                },
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    // children: <Widget>[
                    onTap: () {
                      check = 'ok';
                      print('tap');
                      if (numOne == '') {
                        numOne = result;
                        result = '';
                      } else {
                        numTwo = result;
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '$text',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 100,
                        ),
                      ),
                    ),
                    // ],
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: <Widget>[
              // Calculator display
              // SingleChildScrollView(
              // scrollDirection: Axis.vertical,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcbutton('1', Colors.grey, Colors.white),
                  calcbutton('2', Colors.grey, Colors.white),
                  // calcbutton('%', Colors.grey, Colors.black),
                  // calcbutton('/', Colors.amber, Colors.white),
                ],
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  calcbutton('3', Colors.grey, Colors.white),
                  calcbutton('4', Colors.grey, Colors.white),
                  // calcbutton('9', Colors.grey, Colors.white),
                  // calcbutton('x', Colors.amber, Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // calcbutton('4', Colors.grey, Colors.white),
                  calcbutton('5', Colors.grey, Colors.white),
                  calcbutton('6', Colors.grey, Colors.white),
                  // calcbutton('-', Colors.amber, Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // calcbutton('', Colors.grey, Colors.white),
                  calcbutton('ok', Colors.grey, Colors.white),
                  // calcbutton('3', Colors.grey, Colors.white),
                  // calcbutton('+', Colors.amber, Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: <Widget>[
              //     //this is button Zero
              //     RaisedButton(
              //       padding: EdgeInsets.fromLTRB(34, 20, 128, 20),
              //       onPressed: () {
              //         calculation('0');
              //       },
              //       shape: StadiumBorder(),
              //       child: Text(
              //         '0',
              //         style: TextStyle(fontSize: 35, color: Colors.white),
              //       ),
              //       color: Colors.grey[850],
              //     ),
              //     calcbutton('.', Colors.grey, Colors.white),
              //     calcbutton('=', Colors.amber, Colors.white),
              //   ],
              // ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          // ],
        ),
        // ),
      ),
    );
  }

  //Calculator logic
  dynamic text = '0';
  dynamic numOne = '';
  dynamic numTwo = '';

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (check == 'ok' || btnText == 'ok') {
      if (numOne == '') {
        numOne = result;
        check = '';
        result = '';
      } else {
        numTwo = result;
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      // finalResult = result;
    }

    switch (numOne) {
      case '1':
        {
          finalResult += 'a';
          numOne = '';
          break;
        }
      case '13':
        {
          finalResult += 'b';
          numOne = '';
          break;
        }
      case '12':
        {
          finalResult += 'c';
          numOne = '';
          break;
        }
      case '124':
        {
          finalResult += 'd';
          numOne = '';
          break;
        }
      case '14':
        {
          finalResult += 'e';
          numOne = '';
          break;
        }
      case '123':
        {
          finalResult += 'f';
          numOne = '';
          break;
        }
      case '1234':
        {
          finalResult += 'g';
          numOne = '';
          break;
        }
      case '134':
        {
          finalResult += 'h';
          numOne = '';
          break;
        }
      case '23':
        {
          finalResult += 'i';
          numOne = '';
          break;
        }
      case '234':
        {
          finalResult += 'j';
          numOne = '';
          break;
        }
      case '15':
        {
          finalResult += 'k';
          numOne = '';
          break;
        }
      case '135':
        {
          finalResult += 'l';
          numOne = '';
          break;
        }
      case '125':
        {
          finalResult += 'm';
          numOne = '';
          break;
        }
      case '1245':
        {
          finalResult += 'n';
          numOne = '';
          break;
        }
      case '145':
        {
          finalResult += 'o';
          numOne = '';
          break;
        }
      case '1235':
        {
          finalResult += 'p';
          numOne = '';
          break;
        }
      case '12345':
        {
          finalResult += 'q';
          numOne = '';
          break;
        }
      case '1345':
        {
          finalResult += 'r';
          numOne = '';
          break;
        }
      case '235':
        {
          finalResult += 's';
          numOne = '';
          break;
        }
      case '2345':
        {
          finalResult += 't';
          numOne = '';
          break;
        }
      case '156':
        {
          finalResult += 'u';
          numOne = '';
          break;
        }
      case '1356':
        {
          finalResult += 'v';
          numOne = '';
          break;
        }
      case '2346':
        {
          finalResult += 'w';
          numOne = '';
          break;
        }
      case '1256':
        {
          finalResult += 'x';
          numOne = '';
          break;
        }
      case '12456':
        {
          finalResult += 'y';
          numOne = '';
          break;
        }
      case '1456':
        {
          finalResult += 'z';
          numOne = '';
          break;
        }
    }

    // if (numOne == '1') {
    //   text = 'a';
    //   // numOne = 0;
    //   numTwo = 0;
    //   // result = 'a';
    //   finalResult = finalResult + text;
    //   opr = '';
    //   preOpr = '';
    //   numOne = '';
    // } else if (numOne == '13') {
    //   text = 'b';
    //   // numOne = 0;
    //   numTwo = 0;
    //   // result = 'a';
    //   finalResult = finalResult + text;
    //   opr = '';
    //   preOpr = '';
    // } else if (numOne == '12') {
    //   text = 'c';
    //   // numOne = 0;
    //   numTwo = 0;
    //   // result = 'a';
    //   finalResult = finalResult + text;
    //   opr = '';
    //   preOpr = '';
    // } else if (numOne == '124') {
    //   text = 'd';
    //   // numOne = 0;
    //   numTwo = 0;
    //   // result = 'a';
    //   finalResult = finalResult + text;
    //   opr = '';
    //   preOpr = '';
    // } else if (numOne == '14') {
    //   text = 'e';
    //   // numOne = 0;
    //   numTwo = 0;
    //   // result = 'a';
    //   finalResult = finalResult + text;
    //   opr = '';
    //   preOpr = '';
    // }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
