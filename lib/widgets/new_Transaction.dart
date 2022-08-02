import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';

class NewTransaction extends StatefulWidget {
  final Function newTranxCall;
  NewTransaction(this.newTranxCall);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  DateTime _selectedDate = DateTime.now();
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitDataCheck() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enterTitle = titleController.text;
    final enterAmount = double.parse(amountController.text);
    if (enterTitle.isEmpty || enterAmount <= 0) {
      AlertDialog(
        title:
            Text('Invalid command..!'), // To display the title it is optional
        content: Text(
            'Please Enter a correct data'), // Message which will be pop up on the screen
        // Action widget which will provide the user to acknowledge the choice
        actions: [
          FlatButton(
            textColor: Colors.black,
            onPressed: () {},
            child: Text('OK'),
          ),
        ],
      );
    } else {
      widget.newTranxCall(
        titleController.text,
        double.parse(amountController.text),
        _selectedDate,
      );
      Navigator.of(context).pop();
    }
  }

  void _selectdate() {
    Platform.isAndroid
        ? showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2022),
                lastDate: DateTime.now())
            .then((value) {
            if (value == null) {
              return;
            }
            setState(() {
              _selectedDate = value;
            });
          })
        : showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: 500,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime.now(),
                        maximumDate: DateTime.now(),
                        minimumYear: 2022,
                        onDateTimeChanged: (val) {
                          setState(() {
                            _selectedDate = val;
                          });
                        }),
                        
                  ),
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),)
                  ],
              ),
            ));
  }

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitDataCheck(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitDataCheck(),
            ),
            /////////      for Ios TextFeild   //////////
            // CupertinoTextField(
            //   //decoration: InputDecoration(labelText: 'Amount'),
            //   prefix: Text('\$'),
            //   placeholder: '34.67',
            //   controller: amountController,
            //   keyboardType: TextInputType.numberWithOptions(decimal: true),
            //   onSubmitted: (_) => submitDataCheck(),
            // ),
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Select'
                          : 'Picked Date: ' +
                              DateFormat.yMd().format(_selectedDate))),
                  TextButton(
                      onPressed: _selectdate,
                      child: Text('Choose Date',
                          style: TextStyle(color: Colors.blue)))
                ],
              ),
            ),
            TextButton(
                child: Text('Add Transaction',
                    style: TextStyle(color: Colors.purple)),
                onPressed: submitDataCheck),
          ],
        ),
      ),
    );
  }
}
