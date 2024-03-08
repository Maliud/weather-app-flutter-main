
import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {

  final String day;
  final String date;

  const Tabs({
    super.key,
    required this.day,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: Column(
        children: [
          Text(
            day,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            date,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
