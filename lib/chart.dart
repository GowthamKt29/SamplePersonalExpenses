import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transactions.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transactions> userTrans;

  const Chart(this.userTrans, {Key? key}) : super(key: key);

  List<Map<String, dynamic>> get groupedTraxnsactionDetails {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalAmt = 0;
      for (var i = 0; i < userTrans.length; i++) {
        if (userTrans[i].date.day == weekDay.day &&
            userTrans[i].date.month == weekDay.month &&
            userTrans[i].date.year == weekDay.year) {
          totalAmt += userTrans[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmt
      };
    });
  }

  double get totalSpending {
    return groupedTraxnsactionDetails.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTraxnsactionDetails.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(data['day'] as String, data['amount'] as double,
                  (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
