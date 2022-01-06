import 'package:flutter/material.dart';
import './chart_bar.dart';
import 'package:app2/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  const Chart({
    Key? key,
    required this.recentTransactions,
  }) : super(key: key);

  List<Map<String, Object>> get groupedTransactionvVlues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (Transaction ts in recentTransactions) {
        if (ts.date.day == weekDay.day &&
            ts.date.month == weekDay.month &&
            ts.date.year == weekDay.year) {
          totalSum += ts.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amoumt': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionvVlues[0]['amoumt'].runtimeType);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionvVlues.map((data) {
          // double amount = data['amount'];
          // return ChartBar('${data['day']}: ${data['amout']}');
          return ChartBar(
            label: data['day'].toString(),
            spendingAmount: 0.0,
            spendingPctofTotal: 0.0,
          );
        }).toList(),
      ),
    );
  }
}
