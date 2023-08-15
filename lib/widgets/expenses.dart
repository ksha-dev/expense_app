import 'package:expense_app/widgets/expense_list/expenses_list.dart';
import 'package:expense_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import '/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter course',
      amount: 455.0,
      date: DateTime.now(),
      category: Category.courses,
    ),
    Expense(
      title: 'Cinema',
      amount: 1500.40,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (modalCtx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  _addExpense(Expense expense) {
    setState(() => _registeredExpenses.add(expense));
  }

  _removeExpense(Expense expense) {
    setState(() => _registeredExpenses.remove(expense));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(
            child: ExpensesList(
              onRemoveExpense: _removeExpense,
              expenses: _registeredExpenses,
            ),
          ),
        ],
      ),
    );
  }
}
