import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/adaptiveButton.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) => amountInput = val,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveButton('Choose Date', _presentDatePicker)
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class NewTransaction extends StatefulWidget {
//   final Function addTx;
//   NewTransaction(this.addTx);

//   @override
//   _NewTransactionState createState() => _NewTransactionState();
// }

// class _NewTransactionState extends State<NewTransaction> {
//   String _title;
//   String _amount;
//   DateTime dateTime;
//   final _titleController = TextEditingController();
//   final _amountController = TextEditingController();
//   DateTime _selectedDate;

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   void _submitData() {
//     if (_amountController.text.isEmpty) {
//       return;
//     }
//     final enteredTitle = _titleController.text;
//     final enteredAmount = double.parse(_amountController.text);
//     if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
//       return;
//     }
//     widget.addTx(
//       enteredTitle,
//       enteredAmount,
//       _selectedDate,
//     );
//     Navigator.of(context).pop();
//   }

//   void _presentDatePicker() {
//     showRoundedDatePicker(
//       customWeekDays: ["MIN", "SEN", "SEL", "RAB", "KAM", "JUM", "SAB"],
//       context: context,
//       theme: ThemeData(
//         primaryColor: dateBlue,
//         accentColor: dateBlue,
//         dialogBackgroundColor: whiteCl,
//         textTheme: TextTheme(
//           bodyText2: TextStyle(color: Colors.red),
//           caption: TextStyle(
//             color: dateBlue,
//           ),
//         ),
//         disabledColor: Color(0xFF05153C),
//         accentTextTheme: TextTheme(
//           bodyText1: TextStyle(color: whiteCl),
//         ),
//       ),
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2020),
//       lastDate: DateTime.now(),
//       borderRadius: 16,
//     ).then((pickedDate) {
//       if (pickedDate == null) {
//         return;
//       }
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     });
//     print('. . .');
//   }

//   Widget _buildNewTx() {
//     return SingleChildScrollView(
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: <Widget>[
//             Container(
//               decoration: BoxDecoration(
//                 gradient: txListCl,
//               ),
//               padding: EdgeInsets.only(
//                   left: 20,
//                   top: 10,
//                   right: 20,
//                   bottom: MediaQuery.of(context).viewInsets.bottom * 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: <Widget>[
//                   _txFieldTitle(),
//                   _txFieldTransaction(),
//                   _dateField(),
//                   RaisedButton(
//                     color: Theme.of(context).accentColor,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.0)),
//                     child: Text(
//                       'Tambah Transaksi',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     textColor: Theme.of(context).textTheme.button.color,
//                     onPressed: _submitData,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _dateField() {
//     return Container(
//       height: 70,
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: Text(
//               _selectedDate == null
//                   ? 'Tgl Belum Dipilih'
//                   : 'Tgl Dipilih: ${DateFormat.yMd().format(_selectedDate)}',
//               style: TextStyle(
//                 color: lightBlue,
//               ),
//             ),
//           ),
//           AdaptiveButton('Pilih Tanggal', _presentDatePicker)
//         ],
//       ),
//     );
//   }

//   Widget _txFieldTitle() {
//     return TextFormField(
//       initialValue: _title,
//       cursorColor: lightBlue,
//       style: TextStyle(
//         color: lightBlue,
//       ),
//       textCapitalization: TextCapitalization.sentences,
//       decoration: InputDecoration(
//         labelText: 'Jenis Transaksi',
//         labelStyle: TextStyle(color: Colors.blue),
//       ),
//     );
//   }

//   Widget _txFieldTransaction() {
//     return TextFormField(
//       initialValue: _amount,
//       cursorColor: lightBlue,
//       style: TextStyle(
//         color: lightBlue,
//       ),
//       decoration: InputDecoration(
//         labelText: 'Biaya Transaksi',
//         labelStyle: TextStyle(color: Colors.blue),
//       ),
//       keyboardType: TextInputType.number,
//     );
//   }

//   // Widget _raisedButton() {
//   //   return RaisedButton(
//   //     color: Theme.of(context).accentColor,
//   //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
//   //     child: Text(
//   //       'Tambah Transaksi',
//   //       style: TextStyle(fontWeight: FontWeight.bold),
//   //     ),
//   //     textColor: Theme.of(context).textTheme.button.color,
//   //     onPressed: _submitData,
//   //   );
//   // }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _buildNewTx();
//   }
// }
