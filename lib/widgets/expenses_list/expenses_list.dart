import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

/// This class is responsible to output the expense list
/// and the style of it.
class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  @override
  Widget build(context) {
    /// ListView.builder is a scrollable list that use when the length of list is unknown.
    /// Therefore, only the visible or about to become visible are going to build
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(
          expenses[index],
        ),
        onDismissed: (direction) => onRemoveExpense(expenses[index]),
        child: ExpenseItem(
          expenses[index],
        ),
      ),
    );
  }
}
