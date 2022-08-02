import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double spendAmount;
  final String ExpenseDay;
  final double spendingPercentOfTotal;
  ChartBar(this.spendAmount, this.ExpenseDay, this.spendingPercentOfTotal);

  @override
  Widget build(BuildContext context) {
    //print('Spend Amount: $spendAmount ExpenseDay: $ExpenseDay Spending% $spendingPercentOfTotal');
    return LayoutBuilder(builder: (cntx, constrains) {
      return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Container(child: Text(ExpenseDay),),
        Container(
          height: constrains.maxHeight * 0.15,
          padding: EdgeInsets.all(4),

          child: FittedBox(child: Text(ExpenseDay))),
        SizedBox(
          height: constrains.maxHeight * 0.05,
        ),
        Container(
          height: constrains.maxHeight * 0.60,
          width: constrains.maxWidth * 0.2,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black, width: 1.0),
                  color: Color.fromRGBO(230, 230, 230, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPercentOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.black,
                    // ),
                    color: Color.fromRGBO(105, 119, 250, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: constrains.maxHeight * 0.05,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          height: constrains.maxHeight * 0.15,
          padding: const EdgeInsets.all(2.0),
          //height: 17,
          child: FittedBox(
            child: Text('\$' + spendAmount.toStringAsFixed(2)),
          ),
        )
      ],
    );
    });
    
  }
}
