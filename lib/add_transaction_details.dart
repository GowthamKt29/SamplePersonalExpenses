import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'adaptive_button.dart';

class AddTransaction extends StatefulWidget {
  // String title="";
  // String amount="";
  final Function onClick;

  const AddTransaction(this.onClick, {Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  final title = TextEditingController();

  final amount = TextEditingController();
  DateTime? _selectedDate;


  void _submitData() {
    final ti = title.text;
    final amt = double.parse(amount.text);
    if (ti.isEmpty || amt <= 0) {
      return;
    }
    widget.onClick(ti, amt, _selectedDate!);
    Navigator.of(context).pop();
  }

  void _openDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom:MediaQuery.of(context).viewInsets.bottom+10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: title,
                // onChanged: (val)=>title=val,
                decoration: InputDecoration(labelText: 'Title'),
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                controller: amount, keyboardType: TextInputType.number,
                // onChanged: (val)=>amount=val,
                decoration: InputDecoration(labelText: 'Amount'),
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(child: _selectedDate == null
                      ? Text('No Date Choosen')
                      : Text(DateFormat.yMMMMd().format(_selectedDate!))),
                  SizedBox(
                    width: 30,
                  ),
                  AdaptiveButton('Choose Date', _openDatePicker)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: Text(
                  'Add Transaction',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
