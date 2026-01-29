import 'dart:math';

import 'package:flutter/material.dart';
import 'package:money_ledger/widgets/chart/chart.dart';
import 'package:money_ledger/widgets/expenses_list/expenses_list.dart';
import 'package:money_ledger/widgets/expenses_list/new_expanse.dart';

import 'package:money_ledger/models/expense.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses>{
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter course',
        amount: 19.99,
        date: DateTime.now(),
        categories: Categories.work
    ),
    Expense(
        title: 'Cinema',
        amount: 15,
        date: DateTime.now(),
        categories: Categories.leisure
    ),
  ];

  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: const Duration(seconds: 3),
            content: const Text('Expense deleted.'),
          action: SnackBarAction(
              label: 'Undo',
              onPressed: (){
                setState(() {
                  _registeredExpenses.insert(expenseIndex, expense);
                });
              }),
        ),
    );
  }


  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty){
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

   return Scaffold(
     appBar: AppBar(
       title: Text('Your Money Ledger'),
       actions: [
         IconButton(
           onPressed: _openAddExpenseOverlay,
             icon: const Icon(Icons.add),
         ),
       ],
     ),
     body: Column(
       children: [
         Chart(expense: _registeredExpenses),
         Expanded(
           child: mainContent
         ),
       ],
     ),
   );
  }
}