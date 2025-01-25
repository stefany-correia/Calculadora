import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = "0";
  String _currentInput = "";
  String _operation = "";
  double _firstOperand = 0;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _currentInput = "";
        _operation = "";
        _firstOperand = 0;
      } else if (value == "=") {
        if (_operation.isNotEmpty && _currentInput.isNotEmpty) {
          double secondOperand = double.parse(_currentInput);
          switch (_operation) {
            case "+":
              _output = (_firstOperand + secondOperand).toString();
              break;
            case "-":
              _output = (_firstOperand - secondOperand).toString();
              break;
            case "x":
              _output = (_firstOperand * secondOperand).toString();
              break;
            case "/":
              _output = secondOperand != 0
                  ? (_firstOperand / secondOperand).toString()
                  : "Erro";
              break;
          }
          _currentInput = "";
          _operation = "";
        }
      } else if (["+", "-", "x", "/"].contains(value)) {
        if (_currentInput.isNotEmpty) {
          _firstOperand = double.parse(_currentInput);
          _operation = value;
          _currentInput = "";
        }
      } else {
        _currentInput += value;
        _output = _currentInput;
      }
    });
  }

  Widget _buildButton(String label) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                _output,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("/")
                ],
              ),
              Row(
                children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("x")
                ],
              ),
              Row(
                children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-")
                ],
              ),
              Row(
                children: [
                  _buildButton("C"),
                  _buildButton("0"),
                  _buildButton("="),
                  _buildButton("+")
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
