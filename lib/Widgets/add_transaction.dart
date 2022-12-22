import 'package:expense_calculate/Model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransation extends StatefulWidget {
  final Function transactionAdded;

  AddTransation({required this.transactionAdded});

  @override
  State<AddTransation> createState() => _AddTransationState();
}

class _AddTransationState extends State<AddTransation> {
  final titleController = TextEditingController();
  final ammountController = TextEditingController();

  DateTime? _selectedDate;
  DateTime date = DateTime.now();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmmount = double.parse(ammountController.text);

    if (enteredAmmount <= 0 || enteredTitle.isEmpty || _selectedDate == Null) {
      return;
    }

    widget.transactionAdded(
      enteredTitle,
      enteredAmmount,
      _selectedDate,
    );

    Navigator.pop(context);
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == Null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        date = _selectedDate!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Name of the Product',
                ),
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter the ammount',
                ),
                controller: ammountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => submitData(),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _selectedDate == Null
                        ? "No date Chosen!"
                        : DateFormat.yMd().format(date),
                  ),
                  TextButton(
                    onPressed: () {
                      _presentDatePicker();
                    },
                    child: Text("Chose Date"),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: submitData,
                child: Text(
                  "Add Transaction",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
