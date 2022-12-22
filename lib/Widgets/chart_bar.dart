import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String lebel;
  final double spendingAmmount;
  final double spendingPercentage;
  const ChartBar({required this.lebel,required this.spendingAmmount,this.spendingPercentage = 0.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
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
                  heightFactor: spendingPercentage,
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
          Text(lebel),
        ],
      ),
    );
  }
}
