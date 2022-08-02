import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:udemy_expense_flutter_application/models/transaction.dart';
import 'package:udemy_expense_flutter_application/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(7, (index) {
      double totalAmount = 0.0;
      final weekDay = DateTime.now().subtract(Duration(days: index));

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].dateTime.day == weekDay.day &&
            recentTransaction[i].dateTime.month == weekDay.month &&
            recentTransaction[i].dateTime.year == weekDay.year) {
          totalAmount += recentTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount
      };
    }).reversed.toList();//reverse the order of list to get last day of wwek to display first
  }

  double get totalSpending {
    return groupedTransactionValue.fold(0.0, (previousValue, element) {
      return previousValue += element['amount'] as double;
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(groupedTransactionValue);
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: groupedTransactionValue.map((e) {
              return Expanded(
                child: ChartBar(e['amount'] as double, e['day'] as String,
                    totalSpending == 0.0
                    ? 0.0
                    : (e['amount'] as double) / totalSpending),
              );
            }).toList(),
          ),
        ),
        // child: Center(
        //   child: Text(
        //     'Hey, I\'m Card here to Welcome you ' ,
        //     style: Theme.of(context).textTheme.headline1,
        //     //+groupedTransactionValue.toString()
        //     // TextStyle(
        //     //   color: Colors.white,
        //     //   fontWeight: FontWeight.bold,
        //     // ),
        //   ),
        // ),
      ),
    );
  }
}
