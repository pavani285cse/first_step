import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'AddExpense.dart';
import 'AddIncome.dart';
import 'statistics.dart';
import 'transaction.dart';
import 'addbill.dart'; 

class HomeDashboard extends StatefulWidget {
  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  bool _balanceVisible = true;
  int _selectedIndex = 0;

  final List<String> categories = ['Food', 'Rent', 'Shopping', 'Travel'];
  final List<double> budget = [500, 1200, 300, 400];
  final List<double> actual = [450, 1300, 250, 500];
  List<Map<String, dynamic>> _transactions = [
    {
      'description': 'Rental Income',
      'amount': '+\$6,500.00',
      'date': '12 July 2021',
      'color': Colors.green,
    },
    {
      'description': 'Grocery Shopping',
      'amount': '-\$300.49',
      'date': '22 July 2021',
      'color': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome back, Pavani!'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(
              _balanceVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () => setState(() => _balanceVisible = !_balanceVisible),
          ),
        ],
      ),
      body: _selectedIndex == 0
          ? _buildHomeBody()
          : _selectedIndex == 1
              ? StatisticsPage()
              : _selectedIndex == 2
                  ? TransactionsOverview()
                  : Center(child: Text('Tap the + icon to add a bill reminder')),

      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.remove_circle, color: Colors.red),
                          title: Text('Add Expense', style: TextStyle(color: Colors.black)),
                          onTap: () async {
                            Navigator.pop(context);
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => AddExpensePage()),
                            );
                            if (result != null) {
                              setState(() {
                                _transactions.insert(0, result);
                              });
                            }
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.add_circle, color: Colors.green),
                          title: Text('Add Income', style: TextStyle(color: Colors.black)),
                          onTap: () async {
                            Navigator.pop(context);
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => AddIncomePage()),
                            );
                            if (result != null) {
                              setState(() {
                                _transactions.insert(0, result);
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              backgroundColor: Colors.indigo,
              child: Icon(Icons.add),
            )
          : null,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) async {
          if (index == 3) {
            final result = await showDialog(
              context: context,
              builder: (context) => AddBillDialog(),
            );
            if (result != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Bill "${result['title']}" added. Due: ${result['dueDate']}',
                  ),
                ),
              );
            }
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Stats'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Transactions'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Add Bill'),
        ],
      ),
    );
  }

  Widget _buildHomeBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Budget vs Actual',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 250,
            child: BarChart(
              BarChartData(
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            index >= 0 && index < categories.length ? categories[index] : '',
                            style: TextStyle(fontSize: 12),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                barGroups: List.generate(categories.length, (index) {
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: budget[index],
                        width: 8,
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      BarChartRodData(
                        toY: actual[index],
                        width: 8,
                        color: actual[index] > budget[index] ? Colors.red : Colors.greenAccent,
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Transfer', 'Receipt', 'Add Expense', 'Add Income'].map(
              (label) {
                return Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.indigo[100],
                      child: Icon(Icons.add, color: Colors.indigo),
                    ),
                    SizedBox(height: 5),
                    Text(label, style: TextStyle(fontSize: 12)),
                  ],
                );
              },
            ).toList(),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _summaryCard("Income", "\$10,320", Colors.green),
              _summaryCard("Expense", "\$7,450", Colors.red),
              _summaryCard("Savings", "\$2,870", Colors.blue),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Recent Transactions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Divider(),
          ..._transactions.map(
            (tx) => _transactionTile(
              tx['description'],
              tx['amount'],
              DateTime.now().toString().substring(0, 10),
              tx['color'],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(String title, String value, Color color) {
    return Card(
      elevation: 2,
      child: Container(
        width: 100,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(value, style: TextStyle(color: color, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _transactionTile(String title, String amount, String date, Color color) {
    return ListTile(
      leading: Icon(Icons.account_balance_wallet, color: color),
      title: Text(title),
      subtitle: Text(date),
      trailing: Text(
        amount,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}

