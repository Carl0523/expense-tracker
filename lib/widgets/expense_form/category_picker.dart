import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expense_tracker/widgets/expense_form/expense_form.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/my_theme.dart';

class CategoryPicker extends StatefulWidget {
  const CategoryPicker({super.key});

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  @override
  Widget build(context) {
    return Row(
      children: [
        Text(
          'Category: ',
          style: GoogleFonts.raleway(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 10),
            ),
            value: choosedCategory,
            isExpanded: true,
            items: Category.values
                .map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(
                      category.name[0].toUpperCase() +
                          category.name.substring(1),
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : kDarkColorScheme.secondary,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() {
              if (value == null) {
                return;
              }
              choosedCategory = value;
            }),
          ),
        ),
      ],
    );
  }
}
