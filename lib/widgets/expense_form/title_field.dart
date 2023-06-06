import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class TitleField extends StatefulWidget {
  final TextEditingController titleController;

  const TitleField({super.key, required this.titleController});

  @override
  State<TitleField> createState() => _TitleFieldState();
}

class _TitleFieldState extends State<TitleField> {

  
  var emptyField = false;

  ///This is called whenever the titleController change state
  @override
  void initState() {
    super.initState();
    widget.titleController.addListener(() => setState(() {}));
  }

  /// This is called automatically by Flutter when the
  /// widget and its state about to be removed
  @override
  void dispose() {
    widget.titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return TextField(
      maxLength: 50,
      controller: widget.titleController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        label: const Text('Title'),
        hintText: 'Walmart',
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
        ),

        /// Display the clear button only when text field is not empty
        suffixIcon: widget.titleController.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                icon: const FaIcon(FontAwesomeIcons.xmark),
                onPressed: () => widget.titleController.clear(),
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
        if (value.isEmpty)
        {
          emptyField = true;
        }
        else
        {
          emptyField = false;
        }
      }),
    );
  }
}
