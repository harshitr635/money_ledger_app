import 'package:flutter/material.dart';
import 'package:money_ledger/models/expense.dart';
import 'package:money_ledger/widgets/chart/chart_bar.dart';

class Chart extends StatelessWidget{
  const Chart({super.key, required this.expense});

  final List<Expense> expense;

  List<ExpenseBucket> get buckets {
    return[
      ExpenseBucket.forCategory(expense, Categories.food),
      ExpenseBucket.forCategory(expense, Categories.leisure),
      ExpenseBucket.forCategory(expense, Categories.travel),
      ExpenseBucket.forCategory(expense, Categories.work),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets){
      if(bucket.totalExpenses > maxTotalExpense){
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(100, 95, 255, 0),
            Color.fromARGB(100, 170, 243, 127)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final bucket in buckets)
                ChartBar(
                  fill: bucket.totalExpenses / maxTotalExpense,
                )
            ],
          ),),
          const SizedBox(height: 12,),
          Row(
            children: buckets
                .map(
                (bucket) => Expanded(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
    categoryIcons[bucket.categories],
    color: isDarkMode
    ? Theme.of(context).colorScheme.secondary
    : Theme.of(context)
                      .colorScheme
                      .primary
    ),
    ),
          ),
          ).toList(),
          )
        ],
      ),
    );
  }
}