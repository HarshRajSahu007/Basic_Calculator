import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  int x = 0;
  int y = 0;
  num z = 0;

  late final AppLifecycleListener _listener;
  final displayOneController = TextEditingController();
  final displayTwoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayOneController.text = x.toString();
    displayTwoController.text = y.toString();
    _listener = AppLifecycleListener(
      onShow: _onShow,
      onHide: _onHide,
      onDetach: _onDetach,
      onInactive: _onInactive,
      onRestart: _onRestart,
      onPause: _onPause,
      onResume: _onResume,
      onStateChange: _onStateChange,
    );
  }

  void _onShow() => print("On Show called");
  void _onHide() => print("On Hide Called");
  void _onDetach() => print("On Detach Called");
  void _onInactive() => print("On Inactive called");
  void _onRestart() => print("OnRestart called");
  void _onPause() => print("On pause called");
  void _onResume() => print("On Resume Called");

  void _onStateChange(AppLifecycleState state) {
    print("OnstateChange called with State: $state");
  }

  @override
  void dispose() {
    displayOneController.dispose();
    displayTwoController.dispose();
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          CalculatorDisplay(
              hint: "Enter First Number", controller: displayOneController),
          SizedBox(
            height: 30,
          ),
          CalculatorDisplay(
              hint: "Enter Second Number", controller: displayTwoController),
          const SizedBox(
            height: 30,
          ),
          Text(
            z.toString(),
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    z = num.tryParse(displayOneController.text)! +
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                child: Icon(CupertinoIcons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    z = num.tryParse(displayOneController.text)! -
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                child: Icon(CupertinoIcons.minus),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    z = num.tryParse(displayOneController.text)! *
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                child: Icon(CupertinoIcons.multiply),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    z = num.tryParse(displayOneController.text)! /
                        num.tryParse(displayTwoController.text)!;
                  });
                },
                child: Icon(CupertinoIcons.divide),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                x = 0;
                y = 0;
                z = 0;
                displayOneController.clear();
                displayTwoController.clear();
              });
            },
            label: Text("Clear"),
          )
        ],
      ),
    );
  }
}

class CalculatorDisplay extends StatelessWidget {
  const CalculatorDisplay(
      {super.key, this.hint = "Enter a Number", required this.controller});

  final String? hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      autofocus: true,
      keyboardAppearance: Brightness.dark,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 3.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(10)),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black,
          )),
    );
  }
}
