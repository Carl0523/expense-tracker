import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget
{
  const SubmitButton({super.key, required this.addExpense});

  final void Function() addExpense;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {


  @override
  Widget build(context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.addExpense,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
