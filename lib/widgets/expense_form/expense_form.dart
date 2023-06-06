import 'dart:io';

import 'package:expense_tracker/widgets/expense_form/amount_field.dart';
import 'package:expense_tracker/widgets/expense_form/calendar_picker.dart';
import 'package:expense_tracker/widgets/expense_form/heading.dart';
import 'package:expense_tracker/widgets/expense_form/title_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:expense_tracker/widgets/expense_form/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_form/category_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Current date
final now = DateTime.now();

// Date formatter for calender date: ex. 5/23/02
final formatter = DateFormat.yMd();

// Current time by user
DateTime currTime = now;

Category choosedCategory = Category.entertainment;

class ExpenseForm extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;

  const ExpenseForm({super.key, required this.onAddExpense});

  @override
  State<ExpenseForm> createState() {
    return _ExpenseFormState();
  }
}

class _ExpenseFormState extends State<ExpenseForm> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  /// This method generate a calendar picker that has a available time
  /// up to two years old
  // void _datePicker() async {
  //   final now = DateTime.now();
  //   final firstDate = DateTime(now.year - 2, now.month, now.day);

  //   resultDate = await showDatePicker(
  //     context: context,
  //     initialDate: now,
  //     firstDate: firstDate,
  //     lastDate: now,
  //     builder: (context, child) => Theme(
  //       data: Theme.of(context).copyWith(
  //         colorScheme: const ColorScheme.light().copyWith(
  //           primary: const Color(0xff516AD6),
  //         ),
  //       ),
  //       child: child!,
  //     ),
  //   );
  //   setState(() {});
  // }

  /// This date picker is more preferrable for phone user
  /// it provides a scrollable date picker screen
  void _datePicker() {
    currTime = DateTime(now.year, now.month, now.day);
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => SizedBox(
        height: 250,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          maximumYear: now.year,
          minimumYear: now.year - 2,
          backgroundColor: const Color(0xffE9ECFB),
          initialDateTime: currTime,
          onDateTimeChanged: (newTime) => setState(() {
            currTime = newTime;
          }),
        ),
      ),
    );
  }

  /// Show different style of Alert Dialog based on the platform
  /// CupertinoAlertDialog is use for IOS platform, AlertDialogue is use
  /// for other platforms
  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          // The warning icon
          // icon: Icon(
          //   FontAwesomeIcons.circleExclamation,
          //   color: Colors.red.shade700,
          //   size: 35,
          //   fill: 0,
          // ),

          // The title of the alert dialogue
          title: const Text(
            'Attention!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),

          // The content of the alert dialogue
          content: const Text(
            'Title and Amount cannot be empty',
            style: TextStyle(fontSize: 15),
          ),

          // Background color for alert dialogue
          // backgroundColor: const Color(0xffE9ECFB),

          // Contain a elevated button that serves as a confirm button
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    color: Color(0xff007AFF),
                    fontSize: 17,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          // The warning icon
          icon: Icon(
            FontAwesomeIcons.circleExclamation,
            color: Colors.red.shade700,
            size: 35,
            fill: 0,
          ),

          // The title of the alert dialogue
          title: const Text(
            'Attention!',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 51, 80, 210)),
          ),

          // The content of the alert dialogue
          content: const Text(
            '"Title" and "Amount" fields cannot be left empty. Please provide the necessary information.',
            style: TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 88, 110, 209)),
            textAlign: TextAlign.center,
          ),

          // Background color for alert dialogue
          backgroundColor: const Color(0xffE9ECFB),

          // Contain a elevated button that serves as a confirm button
          actions: [
            Center(
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xff516AD6),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(ctx);
                },
                icon: const Icon(
                  FontAwesomeIcons.check,
                  size: 20,
                  color: Colors.white,
                ),
                label: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  /// This method check the conditions for invalid input by users
  /// error message will be thrown. And add the new expense, then display
  /// on the home page
  void _submitExpense() {
    // Pop-up error message
    if (titleController.text.isEmpty || amountController.text.isEmpty) {
      _showDialog();
      return; // Avoid the implementation of creating expense
    }

    // Create the expense and added to the list
    widget.onAddExpense(
      Expense(
        title: titleController.text,
        amount: double.parse(amountController.text),
        date: currTime,
        category: choosedCategory,
      ),
    );
    Navigator.pop(context);
  }

  /*-------------- build start from here ---------------*/
  @override
  Widget build(context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Padding(
        padding: screenwidth < 600
            ? const EdgeInsets.fromLTRB(25, 125, 25, 50)
            : const EdgeInsets.fromLTRB(25, 25, 25, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // The top image
            Center(
              child: screenwidth < 600
                  ? Image.asset(
                      'assets/piggy_bank1.png',
                      cacheWidth: 400,
                    )
                  : null,
            ),

            // 1. The heading and the close button
            const Heading(),

            // Space
            const SizedBox(height: 15),

            // 2. Title of the expense
            TitleField(
              titleController: titleController,
            ),

            // Space
            const SizedBox(height: 8),

            // 3. Amount of the expense and the date picker
            Row(
              children: [
                // The amount field
                Expanded(
                    child: AmountField(
                  amountController: amountController,
                )),

                // Calendar icon and the text field to store the date
                Expanded(
                  child: CalendarPicker(showCalendar: _datePicker),
                ),
              ],
            ),

            // Space
            const SizedBox(height: 15),

            // 4. Category
            const CategoryPicker(),

            const SizedBox(
              height: 30,
            ),

            // 5. The 'submit' button
            SubmitButton(
              addExpense: _submitExpense,
            ),
          ],
        ),
      ),
    );
  }
}
