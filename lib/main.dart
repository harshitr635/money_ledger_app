import 'package:flutter/material.dart';
import 'package:money_ledger/widgets/expenses.dart';

void main(){
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: Expenses(),
      ), //MaterialApp
  );
}