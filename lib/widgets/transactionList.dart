import 'package:flutter/material.dart';
import '../models/appProperties.dart';
import '../models/transaction.dart';
import '../widgets/transactionItem.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                'Transaksi Kamu Belum Ada',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : Container(
            decoration: const BoxDecoration(
              color: whiteCl,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              gradient: txListCl,
            ),
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionItem(
                    transaction: transactions[index], deleteTx: deleteTx);
              },
              itemCount: transactions.length,
            ),
          );
  }
}
