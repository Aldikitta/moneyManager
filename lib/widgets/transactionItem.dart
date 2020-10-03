import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/appProperties.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);
  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: darkBlue, width: 1),
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: FittedBox(
              child: Text(
                '${transaction.amount}\k',
                style: TextStyle(color: greenCl, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date),
            style: TextStyle(color: Colors.blue)),
        trailing: MediaQuery.of(context).size.width > 360
            ? FlatButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Hapus',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                textColor: Theme.of(context).errorColor,
                onPressed: () {
                  deleteTx(transaction.id);
                },
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  deleteTx(transaction.id);
                },
              ),
      ),
    );
  }
}
