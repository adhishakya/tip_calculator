import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _controller = TextEditingController();

  final List<bool> _selection = [true, false, false];

  String tip = "0.00";

  String totalBill = "0.00";

  void updateSelection(int selectedIndex) {
    setState(() {
      for (int i = 0; i < _selection.length; i++) {
        _selection[i] = selectedIndex == i;
      }
    });
  }

  void calculateTip() {
    final total = double.parse(_controller.text);
    final selectedIndex = _selection.indexWhere((element) => element);
    final tipPercent = [0.1, 0.15, 0.2][selectedIndex];
    final tipAmount = (total * tipPercent);
    final overallAmount = total + tipAmount;

    setState(() {
      tip = tipAmount.toStringAsFixed(2);
      totalBill = overallAmount.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Tip Amount: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  const Icon(Icons.currency_rupee),
                  Text(
                    tip,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Total Bill: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  const Icon(Icons.currency_rupee),
                  Text(
                    totalBill,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 190,
                child: TextField(
                  controller: _controller,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    hintText: "Enter Bill Amount",
                    prefixIcon: Icon(Icons.currency_rupee),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ToggleButtons(
                isSelected: _selection,
                onPressed: updateSelection,
                children: const [
                  SizedBox(
                    width: 60,
                    child: Center(child: Text("10%")),
                  ),
                  SizedBox(
                    width: 60,
                    child: Center(child: Text("15%")),
                  ),
                  SizedBox(
                    width: 60,
                    child: Center(child: Text("20%")),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 120,
                child: TextButton(
                  onPressed: () {
                    calculateTip();
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  child: const Text(
                    "Calculate Tip",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
