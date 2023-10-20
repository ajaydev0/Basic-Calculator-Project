import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "C") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
          result = result.substring(0, result.length - 2);
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget Button({
    dynamic text,
    dynamic bColor,
    dynamic tColor,
    double? tSize = 30,
    double? h = 70,
    double? w = 70,
  }) {
    return SizedBox(
      height: h,
      width: h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: bColor,
        ),
        onPressed: () => buttonPressed(text),
        child: Text(
          text,
          style: TextStyle(color: tColor, fontSize: tSize),
        ),
      ),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    var amber = Colors.amber[700];
    var grey = Colors.grey[400];
    var black = Colors.grey.withOpacity(.30);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calculator",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: amber,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize, color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize, color: Colors.white),
              softWrap: false,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Button(
                text: "AC",
                bColor: grey,
                tColor: Colors.black,
                tSize: 20,
              ),
              Button(
                text: "C",
                bColor: grey,
                tColor: Colors.black,
                tSize: 20,
              ),
              Button(
                text: "%",
                bColor: grey,
                tColor: Colors.black,
                tSize: 30,
              ),
              Button(
                text: "÷",
                bColor: amber,
                tColor: Colors.white,
                tSize: 35,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Button(
                text: "7",
                bColor: black,
                tColor: Colors.white,
                tSize: 30,
              ),
              Button(
                text: "8",
                bColor: black,
                tColor: Colors.white,
                tSize: 30,
              ),
              Button(
                text: "9",
                bColor: black,
                tColor: Colors.white,
                tSize: 30,
              ),
              Button(
                text: "×",
                bColor: amber,
                tColor: Colors.white,
                tSize: 35,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Button(
                text: "4",
                bColor: black,
                tColor: Colors.white,
                tSize: 30,
              ),
              Button(
                text: "5",
                bColor: black,
                tColor: Colors.white,
                tSize: 30,
              ),
              Button(
                text: "6",
                bColor: black,
                tColor: Colors.white,
                tSize: 30,
              ),
              Button(
                tColor: Colors.white,
                tSize: 45,
                text: "-",
                bColor: amber,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Button(
                text: "1",
                bColor: black,
                tColor: Colors.white,
                tSize: 30,
              ),
              Button(
                text: "2",
                bColor: black,
                tColor: Colors.white,
                tSize: 30,
              ),
              Button(
                text: "3",
                bColor: black,
                tColor: Colors.white,
                tSize: 30,
              ),
              Button(
                text: "+",
                bColor: amber,
                tColor: Colors.white,
                tSize: 35,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Button(
                w: 160,
                tColor: Colors.white,
                bColor: black,
                text: "0",
                tSize: 30,
              ),
              Button(
                w: 160,
                tColor: Colors.white,
                bColor: black,
                text: "00",
                tSize: 30,
              ),
              Button(
                text: ".",
                bColor: black,
                tColor: Colors.white,
                tSize: 30,
              ),
              Button(
                text: "=",
                bColor: amber,
                tColor: Colors.white,
                tSize: 35,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
