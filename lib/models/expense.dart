import 'package:uuid/uuid.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

// ignore: slash_for_doc_comments
/**
 * Attributes should include:
 * 1. Date
 * 2. Category
 * 3. Description
 * 4. Amount
 * 5. Title
 * 6. ID
 * 7. Payment method
 */
//The Uuid object
const uuid = Uuid();

/// We have these categories for expense:
/// 1. Housing
/// 2. Transportation
/// 3. Entertainment
/// 4. Food
/// 5. Travel
/// 6. Health
enum Category { housing, transportation, entertainment, food, health, shopping }

/// We have these payments type for expense:
/// 1. Cash
/// 2. Credit Card
/// 3. Debit Card
enum Payment { cash, creditCard, debitCard }

const categoryIcons = {
  Category.food: FontAwesomeIcons.utensils,
  Category.health: FontAwesomeIcons.stethoscope,
  Category.housing: FontAwesomeIcons.house,
  Category.entertainment: FontAwesomeIcons.gamepad,
  Category.transportation: FontAwesomeIcons.truckPlane,
  Category.shopping: FontAwesomeIcons.bagShopping,
};

final formatter = DateFormat.yMEd();

/// Default constructor
/// The [title] is the Expense's name
/// The [amount] indicate the cost of the expense
/// The [date] the expense was used
/// The [description] of the expense
/// The unique [id] of the expense
class Expense {
  final String title;
  final double amount;
  final DateTime date;
  // final String description;
  final String id;
  final Category category;
  // final Payment payment;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    // required this.description,
    required this.category,
    // required this.payment,
  }) : id = uuid.v4();
  //Initialize the pass-in parameter dynamically

  /// Format the date
  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseCalculator {
  final List<Expense> expenses;
  final Category category;

  const ExpenseCalculator({required this.expenses, required this.category});

  // Filter the list to a specific category
  ExpenseCalculator.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  
  double sumExpenses() {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
