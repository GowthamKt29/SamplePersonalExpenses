// import 'package:flutter/material.dart';
// import 'left_column_widget.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Pages'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   // static const descTextStyle = TextStyle(
//   //   color: Colors.black,
//   //   fontWeight: FontWeight.w800,
//   //   fontFamily: 'Roboto',
//   //   letterSpacing: 0.5,
//   //   fontSize: 18,
//   //   height: 2,
//   // );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: SingleChildScrollView(
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child:LeftColumn(),
//                 flex: 2,
//               ),
//               Expanded(
//                   flex: 3,
//                   child: Image.asset('assets/images/banner_fruits.jpg'))
//             ],
//           ),
//         ));
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'transaction_item.dart';
import 'transactions.dart';
import 'add_transaction_details.dart';
import 'chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: _MyHomePage(),
      theme: ThemeData(
          errorColor: Colors.purple,
          primarySwatch: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              subtitle1: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white)),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(fontSize: 20, fontFamily: 'OpenSans'))),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  const _MyHomePage({Key? key}) : super(key: key);

  @override
  State<_MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> with WidgetsBindingObserver {
  final List<Transactions> _usertransaction = [];
  bool _switchChart = false;

  List<Transactions> get _recentTransactions {
    return _usertransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  void _addUserTransaction(String title, double amount, DateTime date) {
    final newTx = Transactions(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);

    setState(() {
      _usertransaction.add(newTx);
    });
  }

  void _deleTransa(String id) {
    setState(() {
      _usertransaction.removeWhere((trx) => trx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: AddTransaction(_addUserTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
    final appBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: [
        IconButton(
            onPressed: () {
              _startAddNewTransaction(context);
            },
            icon: Icon(Icons.add))
      ],
    );
    final txtTransList=Container(
        height: (MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top) *
            0.75,
        child: TransactionsItem(_usertransaction, _deleTransa));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           if(isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show chart'),
                Switch.adaptive(value: _switchChart, onChanged: (val) {
                setState(() {
                  _switchChart=val;
                });
                })
              ],
            ),
            if(!isLandscape)Container(
              child: Chart(_recentTransactions),
              height: (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top) *
                  0.3,
            ),
            if(!isLandscape)txtTransList,
            if(isLandscape)_switchChart? Container(
              child: Chart(_recentTransactions),
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
            ): txtTransList,

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:Platform.isIOS? Container():FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
