import 'package:expense_tracker/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:pie_chart/pie_chart.dart';

class Chart extends StatefulWidget {
  final List<Expense> expenses;

  const Chart({super.key, required this.expenses});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<ExpenseCalculator> get buckets {
    return [
      ExpenseCalculator.forCategory(widget.expenses, Category.entertainment),
      ExpenseCalculator.forCategory(widget.expenses, Category.food),
      ExpenseCalculator.forCategory(widget.expenses, Category.health),
      ExpenseCalculator.forCategory(widget.expenses, Category.housing),
      ExpenseCalculator.forCategory(widget.expenses, Category.shopping),
      ExpenseCalculator.forCategory(widget.expenses, Category.transportation),
    ];
  }

  // List of gradients colors for pie chart values
  List<List<Color>> gradientList = [
    [
      const Color(0xff4da0b0),
      const Color(0xffd39d38),
    ],
    [
      const Color(0xfffd746c),
      const Color(0xffff9068),
    ],
    [
      const Color(0xffc2e59c),
      const Color(0xff64b3f4),
    ],
    [
      const Color(0xff76b852),
      const Color(0xff8dc26f),
    ],
    [
      const Color(0xfff46b45),
      const Color(0xffeea849),
    ],
    [
      const Color(0xff00c9ff),
      const Color(0xff92fe9d),
    ],
  ];

  @override
  Widget build(context) {
    Map<String, double> dataMap = {
      'entertainment': buckets[0].sumExpenses(),
      'food': buckets[1].sumExpenses(),
      'health': buckets[2].sumExpenses(),
      'housing': buckets[3].sumExpenses(),
      'shopping': buckets[4].sumExpenses(),
      'transportation': buckets[5].sumExpenses(),
    };
    return PieChart(
      chartType: ChartType.ring,
      ringStrokeWidth: 30,
      chartLegendSpacing: 30,
      dataMap: dataMap,
      chartRadius: 225,
      centerText: 'Expenses',
      centerTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17,
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : kDarkColorScheme.secondary,
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: false,
        decimalPlaces: 2,
        chartValueStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : kDarkColorScheme.secondary),
      ),
      legendOptions: const LegendOptions(
        legendPosition: LegendPosition.bottom,
        showLegendsInRow: true,
        legendTextStyle: TextStyle(
          fontSize: 15,
        ),
      ),
      gradientList: gradientList,
      animationDuration: const Duration(seconds: 3),
    );
  }
}
