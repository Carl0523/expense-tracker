import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expense_form/expense_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CalendarPicker extends StatefulWidget {
  final void Function() showCalendar;

  const CalendarPicker({super.key, required this.showCalendar});

  @override
  State<CalendarPicker> createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  @override
  Widget build(context) {
    return Row(
      children: [
        IconButton(
          onPressed: widget.showCalendar,
          icon: const Icon(FontAwesomeIcons.calendarDays),
        ),
        Expanded(
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
              labelText: (formatter.format(currTime)),
              labelStyle: TextStyle(
                color: Colors.grey.shade600,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),
      ],
    );
  }
}
