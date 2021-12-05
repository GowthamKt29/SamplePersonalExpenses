import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double totalAmt;
  final double spendingOfTotal;


  ChartBar(this.day, this.totalAmt, this.spendingOfTotal);

  @override
  Widget build(BuildContext context) {
    // print('Total Amt $totalAmt');
    // print(spendingOfTotal);
    return LayoutBuilder(builder: (ctx,constraints){
      return Column(
        children: [
          totalAmt>0? Container(height:constraints.maxHeight * 0.1,child: FittedBox(child: Text('\$${totalAmt.toStringAsFixed(2)}'))):Container(height:constraints.maxHeight * 0.1,child: FittedBox(child: Text('\$${0}'))),
          SizedBox(
            height: 4,
          ),
          Container(
            height: constraints.maxHeight * 0.7,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                ),
                FractionallySizedBox(
                  heightFactor: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(height:constraints.maxHeight * 0.1,child: FittedBox(child: Text(day))),
        ],
      );
    });
  }
}
