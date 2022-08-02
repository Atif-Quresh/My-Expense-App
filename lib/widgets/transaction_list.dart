import 'dart:ffi';
import 'dart:math';
import './transaction_item.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'chart.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> getTransaction;
  Function deleteTranxCall;
  TransactionList(this.getTransaction, this.deleteTranxCall);
  @override
  Widget build(BuildContext context) {
    //print(getTransaction);
    
    return LayoutBuilder(builder: (cntx, constrains) {
      return
          // Container(
          //   color: Color.fromRGBO(246, 248, 252, 1),
          //   //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          //   //elevation: 10,
          //   child:
          getTransaction.isEmpty
              ? Container(
                  //color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: constrains.maxHeight * 0.5,
                        width: constrains.maxWidth * 0.9,
                        child: Image.asset(
                          'assets/images/noDatacopy.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: constrains.maxHeight * 0.05,
                      ),
                      Container(
                        height: constrains.maxHeight * 0.2,
                        child: Text(
                          'No Expense Enter Yet',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: getTransaction.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TransactionItem(getTransactionIndex: getTransaction[index], deleteTranxCall: deleteTranxCall);
                  },
                );
      //);
    });
  }

/////////////     OLD WAY of listing using row and columns /////////////

// Container(
//               padding: const EdgeInsets.all(5),
//               child: Card(
//                 elevation: 10,
//                 color: Colors.white,
//                 child: Row(
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.symmetric(
//                           vertical: 10, horizontal: 10),
//                       decoration: BoxDecoration(
//                           border: Border.all(width: 2, color: Colors.black),
//                           borderRadius: BorderRadius.circular(12)),
//                       padding: const EdgeInsets.all(4),
//                       width: 70,
//                       child: FittedBox(
//                         child: Text(
//                           '\$${getTransaction[index].amount.toStringAsFixed(2)}',
//                           style: const TextStyle(
//                               color: Colors.orange, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           getTransaction[index].title,
//                           style: const TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           DateFormat.yMMMd()
//                               .format(getTransaction[index].dateTime),
//                           style:
//                               const TextStyle(fontSize: 12, color: Colors.grey),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             );
}


