import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:udemy_expense_flutter_application/widgets/chart.dart';
import 'package:udemy_expense_flutter_application/widgets/new_Transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import 'package:flutter/cupertino.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Expense App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //colorScheme: Colors.blue[400],
        //accentColor: Colors.amber,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.black,
              ),
              headline2: TextStyle(
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
              headline3: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
      ),
      //////////////   OLD WAY    ///////
      //    theme:
      // ThemeData(
      //   primaryColor: Colors.red,
      //   fontFamily: 'OpenSans',

      //   // Define the default `TextTheme`. Use this to specify the default
      //   // text styling for headlines, titles, bodies of text, and more.
      //   textTheme: const TextTheme(
      //     headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      //     headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      //     bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'OpenSans'),
      //   ),
      // ),

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double totalAmount = 0;
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: '1A', title: 'Bike work', amount: 45.87, dateTime: DateTime.now()),
    // Transaction(
    //     id: '2A', title: 'Home Repair', amount: 80.41, dateTime: DateTime.now())
  ];
  void _addNewTranx(
      String fieldTitle, double fieldAmount, DateTime chosenDate) {
    final newtranx = Transaction(
        id: DateTime.now().toString(),
        title: fieldTitle,
        amount: fieldAmount,
        dateTime: chosenDate);
    setState(() {
      _userTransactions.insert(0, newtranx);
      totalAmount += fieldAmount;
    });
    //print(newtranx.runtimeType);
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: NewTransaction(_addNewTranx),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    final appbarVar = AppBar(
      title: Text('My Expense', style: Theme.of(context).textTheme.headline1),
      elevation: 0,
      actions: [
        Platform.isIOS
            ? IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: Icon(Icons.add),
                color: Colors.black,
              )
            : Container(),
      ],
      backgroundColor: Color.fromRGBO(246, 248, 252, 1),
    );
 
    // );
    // PreferredSize(child:
    // Platform.isIOS?
    //  CupertinoNavigationBar(
    //     middle: Text('My Expense',
    //         style: Theme.of(context).textTheme.headline1),
    //     trailing: Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: <Widget>[
    //         GestureDetector(
    //           child: Icon(CupertinoIcons.add),
    //           onTap: () => _startAddNewTransaction(context),
    //         ),
    //       ],
    //     ),
    //     backgroundColor: Colors.pink,
    //   ):
    

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              width: double.infinity,
              height: (media.size.height -
                      appbarVar.preferredSize.height -
                      media.padding.top) *
                  0.28,
              child: Chart(_recentTransaction),
            ),
            //SizedBox(height: 30,),
            Container(height: (media.size.height -
                      appbarVar.preferredSize.height -
                      media.padding.top) *
                  0.025,
                  child: Center(child: FittedBox(child: Text('Weekly Chart')),),),
            // Container(height: (media.size.height -
            //     appbarVar.preferredSize.height -
            //     media.padding.top) *
            // 0.02,
            // margin: EdgeInsets.symmetric(horizontal: 16),
            // alignment: Alignment.centerLeft,
            // child: Text('Records List:'),),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              width: double.infinity,
              height: (media.size.height -
                      appbarVar.preferredSize.height -
                      media.padding.top) *
                  0.65,
              child: TransactionList(
                _userTransactions,
                _deleteTransaction,
              ),
            ),

            // Container(
            //   width: double.infinity,
            //   height: 80,
            //   child: Card(
            //     color: Colors.pink[300],
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           'Total Expense enter \$' + totalAmount.toStringAsFixed(2),
            //           style: TextStyle(color: Colors.white),
            //         ),
            //         Text(
            //           'Today Label',
            //           style: TextStyle(color: Colors.white),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? Scaffold(
            //navigationBar: ObstructingPreferredSizeWidget(appbarVar),
            appBar: appbarVar,
            body: pageBody,
            backgroundColor: Color.fromRGBO(246, 248, 252, 1),
          )
        : Scaffold(
            appBar: appbarVar,
            body: pageBody,
            backgroundColor: Color.fromRGBO(246, 248, 252, 1),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.note_add_outlined,
                color: Colors.white,
              ),
              onPressed: () => _startAddNewTransaction(context),
              backgroundColor: Colors.green[200],
            ),
          );
  }
}
