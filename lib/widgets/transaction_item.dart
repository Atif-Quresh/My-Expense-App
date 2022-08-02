import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.getTransactionIndex,
    required this.deleteTranxCall,
  }) : super(key: key);

  final Transaction getTransactionIndex;
  final Function deleteTranxCall;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color.fromRGBO(105, 119, 250, 1),
          radius: 24,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: FittedBox(
              child: Text(
                '\$${getTransactionIndex.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        title: Text(
          getTransactionIndex.title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat.yMMMd()
              .format(getTransactionIndex.dateTime),
          style:
              const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Color.fromRGBO(210, 210, 210, 1),
          ),
          onPressed: () {
            deleteTranxCall(getTransactionIndex.id);
          },
        ),
      ),
    );
  }
}