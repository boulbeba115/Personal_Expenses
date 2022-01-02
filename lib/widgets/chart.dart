// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:personal_expenses_app/widgets/char_bar.dart';

import '../model/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      final DateFormat formatter = DateFormat('E');
      final String formattedDay = formatter.format(weekDay);

      double totalAmountSome = recentTransactions.fold(0, (value, element) {
        if (element.date.day == weekDay.day &&
            element.date.month == weekDay.month &&
            element.date.year == weekDay.year) {
          return value + element.amount;
        }
        return value;
      });
      return {
        'key': formattedDay.substring(0, 1),
        'amount': totalAmountSome,
      };
    });
  }

  double get allweekSpending {
    return recentTransactions.fold(0.0, (sum, item) {
      return sum + item.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionsValues.map((data) {
            return ChartBar(
                data['key'].toString(),
                (data['amount'] as double),
                allweekSpending != 0
                    ? ((data['amount'] as double) / allweekSpending)
                    : 0);
          }).toList(),
        ),
      ),
    );
  }
}
