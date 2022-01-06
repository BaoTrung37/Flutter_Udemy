import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction({
    Key? key,
    required this.addTx,
  }) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleControler = TextEditingController();

  final amountControler = TextEditingController();

  void submitData() {
    final entertTitle = titleControler.text;
    final entertAmount = double.parse(amountControler.text);
    if (entertTitle.isEmpty || entertAmount <= 0) {
      return;
    }
    widget.addTx(
      entertTitle,
      entertAmount,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                label: Text('username'),
              ),
              controller: titleControler,
              onSubmitted: (_) => submitData,
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(
                label: Text('amount'),
              ),
              controller: amountControler,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData,

              // onChanged: (val) => amountInput = val,
            ),
            FlatButton(
              onPressed: submitData,
              child: Text('Add Transition'),
            ),
          ],
        ),
      ),
    );
  }
}
