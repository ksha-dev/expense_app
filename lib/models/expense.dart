import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

const categoryIcons = {
  Category.food: Icons.lunch_dining_rounded,
  Category.travel: Icons.travel_explore_rounded,
  Category.shopping: Icons.shopping_bag_rounded,
  Category.bills: Icons.receipt_long_rounded,
  Category.work: Icons.work_history_rounded,
  Category.leisure: Icons.movie_creation_rounded,
  Category.courses: Icons.book,
};

enum Category {
  food,
  shopping,
  courses,
  bills,
  work,
  travel,
  leisure
} // not wrapped in quotes

class Expense {
  // named parameters

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  //auto assigning the id parameter for each object

  // positional parameters

  // Expense(
  //   this.id,
  //   this.title,
  //   this.amount,
  //   this.date,
  //   this.category,
  // );

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

String dateFormatte(DateTime dateTime) {
  return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
}

class ExpenseBucket {
  //creating user constructors
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((element) => element.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
