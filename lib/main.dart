import 'package:expense_calculate/Widgets/chart.dart';
import 'package:expense_calculate/Widgets/itemsCart.dart';
import 'package:expense_calculate/Widgets/transaction_list.dart';

import './Model/transaction.dart';
import './Widgets/add_transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.cyan)
            .copyWith(secondary: Colors.blueGrey)
            .copyWith(tertiary: Colors.amberAccent),
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _transactionAdded(
      String txTitle, double txAmmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      ammount: txAmmount,
      date: chosenDate == Null ? DateTime.now() : chosenDate,
    );

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return AddTransation(
          transactionAdded: _transactionAdded,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text("Expense Manager"),
        actions: [
          IconButton(
            onPressed: () => startAddNewTransaction(context),
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Chart(recentTransaction: _recentTransactions),
            TransactionList(transaction: _transactions,deleteTransation: _deleteTransaction,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
