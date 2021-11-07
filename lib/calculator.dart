import 'package:flutter/material.dart';
import 'constant.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  Widget btn(buttonText, Color color, Color textcolor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 30),
          ),
          onPressed: () {
            main_calculation(buttonText);
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            primary: color,
            onPrimary: textcolor,
            minimumSize: const Size(80, 50),
            alignment: Alignment.center,
            visualDensity: VisualDensity.standard,
          )),
    );
  }

  // end of button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        // margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: kTextStyle,
                    textAlign: TextAlign.right,
                    maxLines: 1,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                btn('C', kButtonGrayType, kButtonTextColor0), // AARRGGBB
                btn('+/-', kButtonGrayType, kButtonTextColor0),
                btn('%', kButtonGrayType, kButtonTextColor0),
                btn("\u00F7", kButtonOrangeType, kButtonTextColor1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                btn('7', kButtonBlackType, kButtonTextColor1),
                btn('8', kButtonBlackType, kButtonTextColor1),
                btn('9', kButtonBlackType, kButtonTextColor1),
                btn('x', kButtonOrangeType, kButtonTextColor1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                btn('4', kButtonBlackType, kButtonTextColor1),
                btn('5', kButtonBlackType, kButtonTextColor1),
                btn('6', kButtonBlackType, kButtonTextColor1),
                btn('-', kButtonOrangeType, kButtonTextColor1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                btn('1', kButtonBlackType, kButtonTextColor1),
                btn('2', kButtonBlackType, kButtonTextColor1),
                btn('3', kButtonBlackType, kButtonTextColor1),
                btn('+', kButtonOrangeType, kButtonTextColor1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                btn('0', kButtonBlackType, kButtonTextColor1),
                btn('00', kButtonBlackType, kButtonTextColor1),
                btn('.', kButtonBlackType, kButtonTextColor1),
                btn('=', kButtonOrangeType, kButtonTextColor1),
              ],
            ),
          ],
        ),
      ),
    );
  } // end of state class

  void main_calculation(buttonText) {
    if (buttonText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && buttonText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == "\u00F7") {
        finalResult = div();
      }
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == 'x' ||
        buttonText == "\u00F7" ||
        buttonText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == "\u00F7") {
        finalResult = div();
      }
      preOpr = opr;
      opr = buttonText;
      result = '';
    } else if (buttonText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (buttonText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (buttonText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + buttonText;
      finalResult = result;
    }

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
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}
