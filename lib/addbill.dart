
import 'package:flutter/material.dart';

class AddBillDialog extends StatefulWidget {
  @override
  _AddBillDialogState createState() => _AddBillDialogState();
}

class _AddBillDialogState extends State<AddBillDialog> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String amount = '';
  DateTime? dueDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Bill Reminder'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Bill Title'),
                onChanged: (value) => title = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onChanged: (value) => amount = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter an amount' : null,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 1)),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() => dueDate = picked);
                  }
                },
                child: Text(
                    dueDate == null ? 'Select Due Date' : dueDate.toString().split(' ')[0]),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate() && dueDate != null) {
              Navigator.pop(context, {
                'title': title,
                'amount': double.tryParse(amount) ?? 0,
                'dueDate': dueDate!.toString().split(' ')[0],
                'paid': false,
              });
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
