import 'package:flutter/material.dart';

import '../Model/transaction.dart';
import '../Widgets/itemsCart.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTransation;

  TransactionList({required this.transaction, required this.deleteTransation});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 560,
      child: (transaction.length == 0)
          ? Container(
              height: 400,
              child: Image.asset(
                'assets/images/sleepy.png',
                fit: BoxFit.fitWidth,
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return ItemCart(
                  ammount: transaction[index].ammount,
                  name: transaction[index].title,
                  date: transaction[index].date,
                  id: transaction[index].id,
                  deleteTx: deleteTransation,
                );
              },
              itemCount: transaction.length,
            ),
    );
  }
}
