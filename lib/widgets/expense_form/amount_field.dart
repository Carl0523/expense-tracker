import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AmountField extends StatefulWidget {
  final TextEditingController amountController;

  const AmountField({super.key, required this.amountController});

  @override
  State<AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
  var emptyField = false;

  /// Once the state of the amountController change, the build cause
  /// the widget to rebuild
  @override
  void initState() {
    super.initState();
    widget.amountController.addListener(() => setState(() {}));
  }

  /// This is called automatically by Flutter when the
  /// widget and its state about to be removed
  @override
  void dispose() {
    widget.amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        // ^ => start, d+ => one or more digits, ? => preceding is optional
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d+\.?\d{0,2}'),
        ),
      ],
      controller: widget.amountController,
      decoration: InputDecoration(
        label: const Text('Amount'),
        prefixIcon: const Icon(
          FontAwesomeIcons.dollarSign,
          size: 20,
        ),

        /// Display the clear icon only when the text is not empty
        suffixIcon: widget.amountController.text.isNotEmpty
            ? IconButton(
                icon: const FaIcon(FontAwesomeIcons.xmark),
                onPressed: () => widget.amountController.clear(),
              )
            : Container(
                width: 0,
              ),

        hintStyle: TextStyle(
          color: Colors.grey.shade500,
        ),

        // Border of the textfield
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),

        // Border style change when focused
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff516AD6),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),

        errorText: emptyField ? 'This field is required.' : null,
      ),
      onChanged: (value) => setState(() {
        if (value.isEmpty) {
          emptyField = true;
        } else {
          emptyField = false;
        }
      }),
    );
  }
}
