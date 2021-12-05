import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'transactions.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class TransactionsItem extends StatefulWidget {
  final List<Transactions> usertransaction;
  final Function deleteClicked;

  TransactionsItem(this.usertransaction, this.deleteClicked);

  @override
  State<TransactionsItem> createState() => _TransactionsItemState();
}

class _TransactionsItemState extends State<TransactionsItem> {
  Color? _bgcolor;
  @override
  void initState() {
    print('InitState');
    // TODO: implement initState
    super.initState();
    const _availableColors=[Colors.red,Colors.green,Colors.purple,Colors.blue,Colors.orange];
    _bgcolor=_availableColors[Random().nextInt(5)];

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.usertransaction.isEmpty
          ? LayoutBuilder(builder: (ctx, constrains) {
              return Column(
                children: [
                  Text(
                    'No Transactions Yet',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: constrains.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _bgcolor,
                      radius: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: FittedBox(
                          child: Text(
                              '\$${widget.usertransaction[index].amount.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                    title: Text(
                      widget.usertransaction[index].title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(widget.usertransaction[index].date),
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    trailing: MediaQuery.of(context).size.width > 500
                        ? TextButton.icon(
                            onPressed: null,
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).errorColor,
                            ),
                            label: Text('Delete',style: Theme.of(context).textTheme.subtitle1,))
                        : IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).errorColor,
                            ),
                            onPressed: () {
                              widget.deleteClicked(widget.usertransaction[index].id);
                            },
                          ),
                  ),
                  // child: Row(
                  //   children: [
                  //     Container(
                  //       margin: const EdgeInsets.symmetric(
                  //           vertical: 10, horizontal: 10),
                  //       decoration: BoxDecoration(
                  //           border: Border.all(
                  //               color: Theme.of(context).primaryColor,
                  //               width: 2)),
                  //       padding: const EdgeInsets.all(10),
                  //       child: Text(
                  //         '\$${usertransaction[index].amount.toStringAsFixed(2)}',
                  //         style: TextStyle(
                  //             color: Theme.of(context).primaryColor,
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 20),
                  //       ),
                  //     ),
                  //     Container(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             usertransaction[index].title,
                  //             style: Theme.of(context).textTheme.subtitle1,
                  //           ),
                  //           Text(
                  //             DateFormat.yMMMMd()
                  //                 .format(usertransaction[index].date),
                  //             style: const TextStyle(
                  //                 color: Colors.grey, fontSize: 15),
                  //           )
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),
                );
              },
              itemCount: widget.usertransaction.length,
            ),
    );
  }
}
