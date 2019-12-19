import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.deepOrange,
          // errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: '4 Books',
      amount: 135.75,
      date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day-5),
    ),
    Transaction(
      id: 't2',
      title: 'RAM DDR4 8GB Apacer',
      amount: 99.99,
      date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day-4),
    ),
    Transaction(
      id: 't3',
      title: 'SSD External 1TB',
      amount: 299.99,
      date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day-3),
    ),
    Transaction(
      id: 't4',
      title: 'coca-cola',
      amount: 99.99,
      date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day-2),
    ),
    Transaction(
      id: 't5',
      title: 'shopping',
      amount: 108,
      date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day-1),
    ),
    Transaction(
      id: 't6',
      title: 'cinema',
      amount: 20,
      date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    ),
    Transaction(
      id: 't7',
      title: 'gym',
      amount: 35,
      date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    ),
    Transaction(
      id: 't8',
      title: 'snacks',
      amount: 80,
      date: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
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
        title: Text(
          'Personal Expenses',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
