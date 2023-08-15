import 'package:flutter/material.dart';

import 'widgets/expenses.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.yellow,
        ),
      ),
      home: const Expenses(),
    ),
  );
}
