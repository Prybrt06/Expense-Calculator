import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemCart extends StatelessWidget {
  final num ammount;
  final String name;
  final DateTime date;
  final String id;
  final Function deleteTx;
  const ItemCart({
    required this.ammount,
    required this.name,
    required this.date,
    required this.id,
    required this.deleteTx,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Colors.cyan,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 35,
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "₹${ammount.toStringAsFixed(0)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            // Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat.yMMMMd().format(date),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () => deleteTx(id),
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
