import 'package:flutter/material.dart';

class TransactionsOverview extends StatefulWidget {
  @override
  _TransactionsOverviewState createState() => _TransactionsOverviewState();
}

class _TransactionsOverviewState extends State<TransactionsOverview> {
  final List<Map<String, dynamic>> incomeList = [
    {'title': 'Salary', 'amount': 6500.0, 'date': '01 June 2025'},
    {'title': 'Freelance', 'amount': 1200.0, 'date': '05 June 2025'},
  ];

  final List<Map<String, dynamic>> expenseList = [
    {'title': 'Groceries', 'amount': 500.0, 'date': '10 June 2025'},
    {'title': 'Rent', 'amount': 2000.0, 'date': '01 June 2025'},
    {'title': 'Online Shopping', 'amount': 800.0, 'date': '15 June 2025'},
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    double totalIncome = incomeList.fold(0, (sum, item) => sum + item['amount']);
    double totalExpense = expenseList.fold(0, (sum, item) => sum + item['amount']);
    double netBalance = totalIncome - totalExpense;

    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions Overview'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(icon: Icon(Icons.download), onPressed: () {
            // Export logic here (e.g. PDF or Excel)
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Total Balance Summary
            Card(
              child: ListTile(
                title: Text('Net Balance'),
                subtitle: Text('\$${netBalance.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 10),

            // Search Field
            TextField(
              decoration: InputDecoration(
                hintText: 'Search by title, amount, or date',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
            SizedBox(height: 20),

            // Income Section
            _sectionTitle('Income'),
            ..._filteredItems(incomeList, isIncome: true),

            SizedBox(height: 20),
            // Expense Section
            _sectionTitle('Expenses'),
            ..._filteredItems(expenseList, isIncome: false),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  List<Widget> _filteredItems(List<Map<String, dynamic>> list, {required bool isIncome}) {
    return list
        .where((item) =>
            item['title'].toLowerCase().contains(searchQuery) ||
            item['amount'].toString().contains(searchQuery) ||
            item['date'].toLowerCase().contains(searchQuery))
        .map((item) => ListTile(
              leading: Icon(Icons.account_balance_wallet,
                  color: isIncome ? Colors.green : Colors.red),
              title: Text(item['title']),
              subtitle: Text(item['date']),
              trailing: Text(
                (isIncome ? '+\$' : '-\$') + item['amount'].toStringAsFixed(2),
                style: TextStyle(
                    color: isIncome ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ))
        .toList();
  }
}
