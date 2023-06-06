import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Heading extends StatefulWidget
{
  const Heading({super.key});

  @override
  State<Heading> createState() => _HeadingState();
}

class _HeadingState extends State<Heading>
{
  @override
  Widget build(context)
  {
    return Row(
            children: [
              // The heading
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'New Expense',
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Fill up the space
              const Spacer(),

              // The close button
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  FontAwesomeIcons.xmark,
                ),
              ),
            ],
          );
  }
}