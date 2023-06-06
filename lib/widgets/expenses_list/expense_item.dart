import 'package:expense_tracker/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:google_fonts/google_fonts.dart';

/// It's reponsible to style one [expense] item in the Expenses ViewList
class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem(this.expense, {super.key});

  @override
  Widget build(context) {
    // ONE expense item in the list
    return Card(
      // Make a round rectangular shape for card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      // Background color of the card
      child: Padding(
        // Padding around the text
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),

        /// A row of three areas:
        /// 1. An Icon of category
        /// 2. a column of title and date
        /// 3. Spacer object: flexible empty space between 2) and 4)
        /// 4. The amount spend
        child: Row(
          children: [
            // 1) Icon of category
            Icon(
              categoryIcons[expense.category],
              color: const Color(0xff3C4155),
            ),

            //Space between 1) and 2)
            const SizedBox(
              width: 15,
            ),

            // 2) Column of title and date
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //The title
                Text(
                  expense.title,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                // Space between title and date
                const SizedBox(
                  height: 5,
                ),

                // The date
                Text(
                  expense.formattedDate,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade800
                        : Colors.white,
                  ),
                ),
              ],
            ),

            // 3) Spacer object
            const Spacer(),

            // 4) Amount spend
            Text(
              '\$${expense.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.light
                    ? const Color(0xff6E7CBC)
                    : kDarkColorScheme.secondary,
                //0xff6E7CBC
              ),
            ),
          ],
        ),
      ),
    );
  }
}
