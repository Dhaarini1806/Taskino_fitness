import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '0';
  String _currentNumber = '';
  String _operation = '';
  double _num1 = 0;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '0';
        _currentNumber = '';
        _operation = '';
        _num1 = 0;
      } else if (buttonText == '+' || buttonText == '-' || buttonText == '×' || buttonText == '÷') {
        _num1 = double.parse(_output);
        _operation = buttonText;
        _currentNumber = '';
        _output = '0';
      } else if (buttonText == '=') {
        double num2 = double.parse(_currentNumber.isEmpty ? '0' : _output);
        if (_operation == '+') _output = (_num1 + num2).toString();
        if (_operation == '-') _output = (_num1 - num2).toString();
        if (_operation == '×') _output = (_num1 * num2).toString();
        if (_operation == '÷') _output = num2 != 0 ? (_num1 / num2).toString() : 'Error';
        _operation = '';
        _currentNumber = _output;
      } else {
        if (_output == '0') {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
        _currentNumber += buttonText;
      }
    });
  }

  Widget _buildButton(String title) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(title),
          style: ElevatedButton.styleFrom(
            backgroundColor: title == 'C' || title == '=' ? Colors.redAccent : Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Text(
              _output,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          const Expanded(child: SizedBox()),
          Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('÷'),
            ],
          ),
          Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('×'),
            ],
          ),
          Row(
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            children: [
              _buildButton('0'),
              _buildButton('C'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }
}