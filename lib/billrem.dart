import 'package:flutter/material.dart';
import 'package:first_step/addbill.dart';

class BillRemindersPage extends StatefulWidget {
  @override
  _BillRemindersPageState createState() => _BillRemindersPageState();
}

class _BillRemindersPageState extends State<BillRemindersPage> {
  List<Map<String, dynamic>> billList = [
    {
      'title': 'Electricity Bill',
      'amount': 1200,
      'dueDate': '2025-07-05',
      'paid': false
    },
    {
      'title': 'Internet',
      'amount': 800,
      'dueDate': '2025-07-10',
      'paid': false
    },
  ];

  void _addBillReminder() async {
    final newBill = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AddBillDialog(),
    );

    if (newBill != null) {
      setState(() => billList.add(newBill));
    }
  }

  void _markAsPaid(int index) {
    setState(() {
      billList[index]['paid'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Reminders & Planner'),
        backgroundColor: Colors.indigo,
        leading: IconButton(onPressed: (){Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back)),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: billList.length,
        itemBuilder: (context, index) {
          final bill = billList[index];
          return Card(
            color: bill['paid'] ? Colors.green[50] : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.receipt_long,
                    color: bill['paid'] ? Colors.green : Colors.indigo,
                    size: 32,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bill['title'],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text('Due: ${bill['dueDate']}'),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹${bill['amount']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: bill['paid'] ? Colors.green : Colors.red,
                        ),
                      ),
                      SizedBox(height: 4),
                      if (!bill['paid'])
                        ElevatedButton(
                          onPressed: () => _markAsPaid(index),
                          child: Text(
                            'Mark as Paid',
                            style: TextStyle(fontSize: 10),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBillReminder,
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}
