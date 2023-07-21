import 'package:expense_tracker/widgets/expense_form/expense_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expense_tracker/widgets/chart.dart';

/// The main screen widget
class Home extends StatefulWidget {
  // Default constructor
  const Home({super.key});

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

/// It's reponsible for updating the UI when needed.
/// It has build method to defind the widget's UI
class _HomeState extends State<Home> {
  final List<Expense> expenses = [];

  /// Add [expense] into the expenses list in order of data
  /// ==> 04/01/2023, 04/02/2023...
  void _addNewExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
      expenses.sort(((a, b) => b.date.compareTo(a.date)));
    });
  }

  /// Remove the expense from the list when swipe away
  void removeExpense(Expense expense) {
    // The index of expense being removed
    int index = expenses.indexOf(expense);

    setState(
      () => expenses.remove(expense),
    );

    // Make sure to clear existed snack bars
    ScaffoldMessenger.of(context).clearSnackBars();

    // Show a snack bar that allow the user to retrieve expense
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text(
          'Expense removed',
          style: TextStyle(
            color: Color(0xFFD3DBFF),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff516AD6),
        action: SnackBarAction(
          label: 'Redo',
          onPressed: () {
            setState(
              () {
                expenses.insert(index, expense);
              },
            );
          },
        ),
      ),
    );
  }

  /// This function open a Modal Bottom sheet for adding
  /// a new expense purpose
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ExpenseForm(
            onAddExpense: _addNewExpense,
          ),
        ),
      ),
    );
  }

  /// Get the total amount of expenses
  double sumExpenses() {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }

  ///--------------------------------Build Start Here--------------------------------------------------------
  @override
  Widget build(context) {
    double expenseSum = sumExpenses();
    double screenWidth = MediaQuery.of(context).size.width;

    // The content to display on the screen
    Widget mainContent = Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // The papers image
          Image.asset(
            'assets/empty_list3.png',
            cacheHeight: 200,
          ),

          // Space
          const SizedBox(
            height: 20,
          ),

          // The Texts
          Text(
            'Add expenses here',
            style: GoogleFonts.roboto(
              fontSize: 30,
              color: Colors.grey.shade700,
            ),
          ),

          // Space
          const SizedBox(
            height: 10,
          ),

          // Widget Span allows us to include non-text widget into the text
          Text.rich(
            TextSpan(
              style:
                  GoogleFonts.roboto(fontSize: 20, color: Colors.grey.shade600),
              text: 'or use the \'',
              children: const [
                WidgetSpan(
                  child: Icon(
                    FontAwesomeIcons.plus,
                    size: 20,
                  ),
                ),
                TextSpan(text: '\' button'),
              ],
            ),
          ),
        ],
      ),
    );

    // When the list is not empty display the expenses instead
    if (expenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: expenses,
        onRemoveExpense: removeExpense,
      );
    }

    return Scaffold(
      // The App bar at the top of the screen
      appBar: AppBar(
        title: Row(children: [
          Image.asset(
            'assets/logo3_edited.PNG',
            cacheWidth: 40,
          ),

          // Space
          const SizedBox(
            width: 10,
          ),

          Text(
            'Expense Tracker',
            style: GoogleFonts.roboto(
              fontSize: 25,
              // color: const Color(0xFFD3DBFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),

        //Make the title on the left of the bar
        centerTitle: false,

        //Add a Icon Button
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(
              FontAwesomeIcons.plus,
              // color: Colors.white,
            ),
          ),
        ],
        toolbarHeight: 55,
      ),

      // The fundamental structure of the screen
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: screenWidth < 600
            ? Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),

                  // 1. The total spending of expenses display text
                  Text(
                    'Total Spending monthly',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade700
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$ ${expenseSum.toStringAsFixed(2)}',
                    style: GoogleFonts.roboto(
                      fontSize: 55,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  // Space between 1)Total spending and 2)Pie chart
                  const SizedBox(
                    height: 20,
                  ),

                  // 2. The chart
                  Chart(expenses: expenses),

                  // Space between 2)chart and 3)text label
                  const SizedBox(
                    height: 20,
                  ),

                  // 3. Text label for expenses
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Latest Activity',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),

                  // 4. The Expenses List
                  Expanded(
                    child: mainContent,
                  ),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Total Spending monthly',
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey.shade700
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$ ${expenseSum.toStringAsFixed(2)}',
                      style: GoogleFonts.roboto(
                        fontSize: 55,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Chart(expenses: expenses),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Latest Activity',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: mainContent,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
