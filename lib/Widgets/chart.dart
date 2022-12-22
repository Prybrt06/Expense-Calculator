import 'package:expense_calculate/Model/transaction.dart';
import 'package:expense_calculate/Widgets/itemsCart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  final List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].ammount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'ammount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['ammount'] as double);
    });
  }

  const Chart({required this.recentTransaction});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(16),
      child: Wrap(
        spacing: 5,
        children: widget.groupedTransactionValues.map((data) {
          // return Text("${data['day']} : ${data['ammount']} ");
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [ 
                Container(
                  height: 20,
                  width: 20,
                  child: FittedBox(
                    child: Text(
                      data['ammount'].toString(),
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 4,
                  child: Stack(
                    // alignment: ,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      FractionallySizedBox(
                        heightFactor: widget.totalSpending == 0.0
                            ? 0.0
                            : (data['ammount'] as double) /
                                (widget.totalSpending),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text(data['day'].toString()),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
