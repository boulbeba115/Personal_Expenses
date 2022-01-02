// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/chart.dart';
import './model/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'OpenSans',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 30,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't0',
      title: 'New Glasses',
      amount: 70.50,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't2',
      title: 'Snaks',
      amount: 16.22,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Snaks',
      amount: 16.22,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Snaks',
      amount: 16.22,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Snaks',
      amount: 16.22,
      date: DateTime.now(),
    )
  ];
  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime dateTime) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: dateTime != null ? dateTime : DateTime.now());
    setState(() {
      _userTransactions.add(newTx);
    });
    Navigator.of(context).pop();
  }

  void _startAtNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (builderCtx) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: [
          IconButton(
            onPressed: () {
              _startAtNewTransaction(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Chart(_recentTransaction),
                elevation: 5,
              ),
            ),
            _userTransactions.length > 0
                ? TransactionList(_userTransactions, _deleteTransaction)
                : Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                        child: Text('No Transaction Added yet !!!',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Quicksand',
                            )),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 300,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAtNewTransaction(context);
        },
      ),
    );
  }
}
