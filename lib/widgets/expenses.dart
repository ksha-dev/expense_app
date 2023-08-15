import 'package:expense_app/widgets/chart/chart.dart';
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
    int index = _registeredExpenses.indexOf(expense);
    setState(() => _registeredExpenses.remove(expense));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Expense Removed'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () =>
                setState(() => _registeredExpenses.insert(index, expense)))));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
        child: Text(
            'No expense entries are found. Add an expense to view it here!'));

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
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: _registeredExpenses.isEmpty
                ? mainContent
                : ExpensesList(
                    onRemoveExpense: _removeExpense,
                    expenses: _registeredExpenses,
                  ),
          ),
        ],
      ),
    );
  }
}
